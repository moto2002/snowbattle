﻿using UnityEngine;
using UnityEditor;

using System.Collections.Generic;

[CustomEditor(typeof(LE_Event_Or)), CanEditMultipleObjects]

public class LE_Event_OR_Editor : Editor
{


    public override void OnInspectorGUI()
    {
        LE_Event_Or cam = target as LE_Event_Or;

        GUILayout.Label(new GUIContent("The Serialize No.:" + cam.SerializeNo));

        serializedObject.Update();

        NGUIEditorTools.BeginContents(true);
        DrawDefaultInspector();
        NGUIEditorTools.EndContents();

        SerializedProperty list = serializedObject.FindProperty("ActionList");
        if (NGUIEditorTools.DrawMinimalisticHeader("ActionList"))
        {
            NGUIEditorTools.BeginContents(true);

            SerializedProperty size = list.FindPropertyRelative("Array.size");
            EditorGUILayout.PropertyField(size);

            EditorGUI.indentLevel += 1;
            for (int i = 0; i < list.arraySize; i++)
            {
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PropertyField(list.GetArrayElementAtIndex(i));
                EditorGUILayout.EndHorizontal();
            }

            EditorGUI.indentLevel -= 1;

            NGUIEditorTools.EndContents();

        }
        serializedObject.ApplyModifiedProperties();
    }


}




