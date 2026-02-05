package com.example.vedaapplication.ui.component

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.vedaapplication.ui.theme.LightGray
import com.example.vedaapplication.ui.theme.SnowWhite

enum class AppButtonStyle {
    Fill, Clear
}

@Composable
fun AppButton(
    modifier: Modifier = Modifier,
    title: String? = null,
    icon: ImageVector? = null,
    shape: Dp = 20.dp,
    width: Dp? = null,
    height: Dp = 48.dp,
    style: AppButtonStyle = AppButtonStyle.Fill,
    enabled: Boolean = true,
    onClick: () -> Unit
) {
    val sizeModifier = Modifier
        .height(height)
        .then(
            if (width != null) Modifier.width(width) else Modifier.fillMaxWidth())

    when (style) {
        AppButtonStyle.Fill -> {
            Button(
                onClick = onClick,
                modifier = modifier.then(sizeModifier),
                enabled = enabled,
                shape = RoundedCornerShape(shape),
                colors = ButtonDefaults.buttonColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    contentColor = Color.White,
                )
            ) {
                ButtonContent(title, icon)
            }
        }

        AppButtonStyle.Clear -> {
            OutlinedButton(
                onClick = onClick,
                modifier = modifier.then(sizeModifier),
                enabled = enabled,
                shape = RoundedCornerShape(shape),
                border = BorderStroke(1.dp, SnowWhite),
                colors = ButtonDefaults.outlinedButtonColors(
                    containerColor = LightGray,
                    contentColor = Color.DarkGray
                )
            ) {
                ButtonContent(title, icon)
            }
        }
    }
}

@Composable
private fun ButtonContent(
    title: String?,
    icon: ImageVector?
) {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.Center
    ) {
        if (icon != null) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                modifier = Modifier.height(18.dp)
            )

            if (title != null) {
                Spacer(modifier = Modifier.width(8.dp))
            }
        }

        if (title != null) {
            Text(
                text = title,
                fontSize = 19.sp,
                fontWeight = FontWeight.SemiBold
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
private fun AppButtonPreview() {
    Column(
        verticalArrangement = Arrangement.spacedBy(15.dp),
    ) {
        AppButton(
            title = "Button",
            style = AppButtonStyle.Fill,
            onClick = {}
        )

        AppButton(
            title = "Button",
            style = AppButtonStyle.Clear,
            onClick = {}
        )
    }
}