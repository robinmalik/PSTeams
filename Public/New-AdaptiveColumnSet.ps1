﻿function New-AdaptiveColumnSet {
    [cmdletBinding()]
    param(
        [scriptblock] $Columns,
        [ValidateSet("Accent", 'Default', 'Emphasis', 'Good', 'Warning', 'Attention')][string] $Style,
        [int] $MinimumHeight,
        [switch] $Bleed,
        # Layout Start
        [ValidateSet('None', 'Small', 'Default', 'Medium', 'Large', 'ExtraLarge', 'Padding')][string] $Spacing,
        [switch] $Separator,
        [ValidateSet("Left", "Center", 'Right')][string] $HorizontalAlignment,
        [ValidateSet('Stretch', 'Automatic')][string] $Height
        # Layout End
    )
    if ($Columns) {
        $TeamObject = [ordered] @{
            "type"                = "ColumnSet"
            "columns"             = @(
                & $Columns
            )
            "style"               = $Style

            # Layout
            "horizontalAlignment" = $HorizontalAlignment
            "height"              = $Height
            "spacing"             = $Spacing
        }
        if ($Bleed) {
            $TeamObject['bleed'] = $true
        }
        if ($MinimumHeight) {
            $TeamObject['minHeight'] = "$($MinimumHeight)px"
        }
        if ($Separator) {
            $TeamObject['separator'] = $Separator.IsPresent
        }
        Remove-EmptyValue -Hashtable $TeamObject
        $TeamObject
    }
}