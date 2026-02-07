//
//  СustomSettingsSection.swift
//  veda
//
//  Created by Евгений Петрукович on 2/6/26.
//

import SwiftUI

private enum SettingsMetrics {
    static let sectionCornerRadius: CGFloat = 20
    static let sectionHorizontalPadding: CGFloat = 10
    static let headerHorizontalPadding: CGFloat = 20
    static let headerBottomSpacing: CGFloat = 6
    
    static let rowHorizontalPadding: CGFloat = 13
    static let rowVerticalPadding: CGFloat = 12
    static let rowInterItemSpacing: CGFloat = 15
    
    static let iconSize: CGFloat = 34
    static let iconCornerRadius: CGFloat = 10
    
    static var dividerLeadingInset: CGFloat {
        rowHorizontalPadding + iconSize + rowInterItemSpacing
    }
}

enum SettingsRowAccessory {
    case none
    case chevron
    case toggle(Binding<Bool>)
    case custom(AnyView)
}

struct SettingsRowModel: Identifiable {
    let id = UUID()
    let iconSystemName: String
    let iconBackground: Color
    let title: String
    let subtitle: String?
    let accessory: SettingsRowAccessory
    
    init(iconSystemName: String,
         iconBackground: Color,
         title: String,
         subtitle: String? = nil,
         accessory: SettingsRowAccessory = .none) {
        self.iconSystemName = iconSystemName
        self.iconBackground = iconBackground
        self.title = title
        self.subtitle = subtitle
        self.accessory = accessory
    }
}

struct SettingsRow: View {
    let iconSystemName: String?
    let iconBackground: Color?
    let title: String
    let subtitle: String?
    let accessory: SettingsRowAccessory
    
    var body: some View {
        HStack(spacing: SettingsMetrics.rowInterItemSpacing) {
            if iconBackground != nil || iconSystemName != nil {
                ZStack {
                    RoundedRectangle(cornerRadius: SettingsMetrics.iconCornerRadius)
                        .fill(iconBackground ?? .clear)
                        .frame(width: SettingsMetrics.iconSize, height: SettingsMetrics.iconSize)
                    Image(systemName: iconSystemName ?? "")
                        .foregroundStyle(.white)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundStyle(.primary)
                    .font(.system(size: 16))
                    .lineLimit(1)
                if let subtitle {
                    Text(subtitle)
                        .foregroundStyle(.secondary)
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(1)
                }
            }
            
            Spacer(minLength: 0)
            
            accessoryView
        }
        .padding(.vertical, SettingsMetrics.rowVerticalPadding)
        .padding(.horizontal, SettingsMetrics.rowHorizontalPadding)
    }
    
    @ViewBuilder
    private var accessoryView: some View {
        switch accessory {
        case .none:
            EmptyView()
        case .chevron:
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.system(size: 14, weight: .semibold))
                .padding(.trailing, 10)
        case .toggle(let binding):
            Toggle("", isOn: binding)
                .labelsHidden()
        case .custom(let anyView):
            anyView
        }
    }
}

struct SettingsDivider: View {
    var body: some View {
        Divider().padding(.leading, SettingsMetrics.dividerLeadingInset)
    }
}

struct CustomSettingsSection<Content: View>: View {
    var header: String?
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if let header {
                Text(header)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, SettingsMetrics.headerHorizontalPadding)
                    .padding(.bottom, SettingsMetrics.headerBottomSpacing)
            }
            VStack(spacing: 0) {
                content()
            }
            .background(Color.header)
            .cornerRadius(SettingsMetrics.sectionCornerRadius)
        }
        .padding(.horizontal, SettingsMetrics.sectionHorizontalPadding)
    }
}

extension CustomSettingsSection where Content == AnyView {
    init(header: String? = nil, rows: [SettingsRowModel]) {
        self.header = header
        self.content = {
            AnyView(
                VStack(spacing: 0) {
                    ForEach(Array(rows.enumerated()), id: \.element.id) { index, row in
                        SettingsRow(
                            iconSystemName: row.iconSystemName,
                            iconBackground: row.iconBackground,
                            title: row.title,
                            subtitle: row.subtitle,
                            accessory: row.accessory
                        )
                        if index < rows.count - 1 {
                            SettingsDivider()
                        }
                    }
                }
            )
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomSettingsSection(
            header: "Внешний вид",
            rows: [
                SettingsRowModel(
                    iconSystemName: "moon.fill",
                    iconBackground: .mint,
                    title: "Тёмная тема",
                    accessory: .chevron
                ),
                SettingsRowModel(
                    iconSystemName: "bell.fill",
                    iconBackground: .orange,
                    title: "Push‑уведомления",
                    accessory: .toggle(.constant(true))
                )
            ]
        )
        
        CustomSettingsSection(header: "О приложении") {
            SettingsRow(
                iconSystemName: "info.circle.fill",
                iconBackground: .blue,
                title: "О приложении",
                subtitle: nil,
                accessory: .chevron
            )
            SettingsDivider()
            SettingsRow(
                iconSystemName: "star.fill",
                iconBackground: .yellow,
                title: "Оценить приложение",
                subtitle: nil,
                accessory: .none
            )
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.vertical, 16)
    .background(Color.mainBackground)
}
