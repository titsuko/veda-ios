package com.example.vedaapplication.ui.component

import androidx.compose.material3.AlertDialog
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import com.example.vedaapplication.R
import com.example.vedaapplication.ui.theme.VedaApplicationTheme

@Composable
fun AppDialog(
    onConfirmation: () -> Unit = {},
    dialogTitle: String = "",
    dialogText: String = "",
) {
    AlertDialog(
        containerColor = MaterialTheme.colorScheme.background,
        title = {
            Text(
                text = dialogTitle,
                style = MaterialTheme.typography.titleLarge,
                color = MaterialTheme.colorScheme.onBackground
            )
        },
        text = {
            Text(
                text = dialogText,
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onBackground
            )
        },
        onDismissRequest = { },
        dismissButton = { },
        confirmButton = {
            TextButton(
                onClick = {
                    onConfirmation()
                }
            ) {
                Text(
                    text = stringResource(R.string.confirm),
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.primary
                )
            }
        },
    )
}

@Preview
@Composable
private fun AppDialogPreview() {
    VedaApplicationTheme {
        AppDialog(
            onConfirmation = {},
            dialogTitle = "Super Dialog",
            dialogText = "This is a super dialog text."
        )
    }
}
