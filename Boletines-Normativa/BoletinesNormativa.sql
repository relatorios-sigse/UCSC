SELECT
        IDPROCESS,
        NMPROCESS,
        NMPROCESSMODEL,
        NMOCCURRENCETYPE,
        IDSLASTATUS,
        IDLEVEL,
        NMDEADLINE,
        DTSTART,
        IDSITUATION,
        NMEVALRESULT,
        NMUSERSTART,
        TYPEUSER,
        IDREVISIONSTATUS,
        NMREVISIONSTATUS,
        DTDEADLINEFIELD,
        IDPROCESSTYPE,
        IDREVISION,
        DTFINISH,
        DTSLAFINISH,
        FGDEADLINE,
        FGSLASTATUS,
        FGSTATUS,
        FGTYPEUSER,
        T0__NMAPROBADOR_1,
        T0__CANTNORM_1,
        T0__NMELABORADOR_1,
        T0__FECHAPROBOLE_6,
        T0__FECHELABBOLE_6,
        T0__FECHINICWORK_6,
        T0__FECHEMISWSBOLE_1,
        T0__IDBOLETITU_1,
        T0__IDWF_1,
        T0__IDBOLETIN_1,
        T0__IDAPROBADOR_1,
        T0__MOTIRECH_2,
        T0__RESWEBCREBOL_1,
        T0__RESWEBDESBOL_1,
        T0__RESWEBSTATUS_1,
        T0__TITUBOLE_1
    FROM
        (SELECT
            IDPROCESS,
            NMPROCESS,
            NMPROCESSMODEL,
            NMOCCURRENCETYPE,
            IDSLASTATUS,
            IDLEVEL,
            NMDEADLINE,
            DTSTART,
            IDSITUATION,
            NMEVALRESULT,
            NMUSERSTART,
            TYPEUSER,
            IDREVISIONSTATUS,
            NMREVISIONSTATUS,
            DTDEADLINEFIELD,
            IDPROCESSTYPE,
            IDREVISION,
            DTFINISH,
            DTSLAFINISH,
            FGDEADLINE,
            FGSLASTATUS,
            FGSTATUS,
            FGTYPEUSER,
            T0__NMAPROBADOR_1,
            T0__CANTNORM_1,
            T0__NMELABORADOR_1,
            T0__FECHAPROBOLE_6,
            T0__FECHELABBOLE_6,
            T0__FECHINICWORK_6,
            T0__FECHEMISWSBOLE_1,
            T0__IDBOLETITU_1,
            T0__IDWF_1,
            T0__IDBOLETIN_1,
            T0__IDAPROBADOR_1,
            T0__MOTIRECH_2,
            T0__RESWEBCREBOL_1,
            T0__RESWEBDESBOL_1,
            T0__RESWEBSTATUS_1,
            T0__TITUBOLE_1 || ' ' || SUBTITULO as T0__TITUBOLE_1
        FROM
            (SELECT
                1 AS QTD,
                WFP.IDPROCESS,
                WFP.NMPROCESS,
                WFP.NMPROCESSMODEL,
                WFP.NMUSERSTART,
                CASE 
                    WHEN WFP.CDEXTERNALUSERSTART IS NOT NULL THEN '#{303826}' 
                    WHEN WFP.CDUSERSTART IS NOT NULL THEN '#{305843}' 
                    ELSE NULL 
                END AS TYPEUSER,
                CASE 
                    WHEN WFP.CDEXTERNALUSERSTART IS NOT NULL THEN 2 
                    WHEN WFP.CDUSERSTART IS NOT NULL THEN 1 
                    ELSE NULL 
                END AS FGTYPEUSER,
                (SELECT
                    GNT.NMGENTYPE 
                FROM
                    GNGENTYPE GNT 
                WHERE
                    WFP.CDWORKFLOWTYPE=GNT.CDGENTYPE) AS NMOCCURRENCETYPE,
                GNRS.IDREVISIONSTATUS,
                GNRS.NMREVISIONSTATUS,
                CASE 
                    WHEN WFP.FGCONCLUDEDSTATUS IS NOT NULL THEN (CASE 
                        WHEN WFP.FGCONCLUDEDSTATUS=1 THEN '#{100900}' 
                        WHEN WFP.FGCONCLUDEDSTATUS=2 THEN '#{100899}' 
                    END) 
                    ELSE (CASE 
                        WHEN (( WFP.DTESTIMATEDFINISH > (CAST(<!%TODAY%> AS DATE) + COALESCE((SELECT
                            QTDAYS 
                        FROM
                            ADMAILTASKEXEC 
                        WHERE
                            CDMAILTASKEXEC=(SELECT
                                TASK.CDAHEAD 
                            FROM
                                ADMAILTASKREL TASK 
                            WHERE
                                TASK.CDMAILTASKREL=(SELECT
                                    TBL.CDMAILTASKSETTINGS 
                                FROM
                                    CONOTIFICATION TBL))), 0))) 
                        OR (WFP.DTESTIMATEDFINISH IS NULL)) THEN '#{100900}' 
                        WHEN (( WFP.DTESTIMATEDFINISH=CAST( trunc(sysdate) AS DATE) 
                        AND WFP.NRTIMEESTFINISH >= (extract(minute 
                    FROM
                        to_timestamp(to_char(sysdate,
                        'dd-mon-yy hh24:mi:ss'),
                        'DD-MON-YYYY HH24:MI:SS')) + extract(hour 
                    FROM
                        to_timestamp(to_char(sysdate,
                        'dd-mon-yy hh24:mi:ss'),
                        'DD-MON-YYYY HH24:MI:SS')) * 60)) 
                        OR (WFP.DTESTIMATEDFINISH > CAST( trunc(sysdate) AS DATE))) THEN '#{201639}' 
                        ELSE '#{100899}' 
                    END) 
                END AS NMDEADLINE,
                CASE 
                    WHEN WFP.FGCONCLUDEDSTATUS IS NOT NULL THEN (CASE 
                        WHEN WFP.FGCONCLUDEDSTATUS=1 THEN 1 
                        WHEN WFP.FGCONCLUDEDSTATUS=2 THEN 3 
                    END) 
                    ELSE (CASE 
                        WHEN (( WFP.DTESTIMATEDFINISH > (CAST( trunc(sysdate) AS DATE) + COALESCE((SELECT
                            QTDAYS 
                        FROM
                            ADMAILTASKEXEC 
                        WHERE
                            CDMAILTASKEXEC=(SELECT
                                TASK.CDAHEAD 
                            FROM
                                ADMAILTASKREL TASK 
                            WHERE
                                TASK.CDMAILTASKREL=(SELECT
                                    TBL.CDMAILTASKSETTINGS 
                                FROM
                                    CONOTIFICATION TBL))), 0))) 
                        OR (WFP.DTESTIMATEDFINISH IS NULL)) THEN 1 
                        WHEN (( WFP.DTESTIMATEDFINISH=CAST( trunc(sysdate) AS DATE) 
                        AND WFP.NRTIMEESTFINISH >= (extract(minute 
                    FROM
                        to_timestamp(to_char(sysdate,
                        'dd-mon-yy hh24:mi:ss'),
                        'DD-MON-YYYY HH24:MI:SS')) + extract(hour 
                    FROM
                        to_timestamp(to_char(sysdate,
                        'dd-mon-yy hh24:mi:ss'),
                        'DD-MON-YYYY HH24:MI:SS')) * 60)) 
                        OR (WFP.DTESTIMATEDFINISH > CAST( trunc(sysdate) AS DATE))) THEN 2 
                        ELSE 3 
                    END) 
                END AS FGDEADLINE,
                WFP.FGSLASTATUS,
                CASE WFP.FGSLASTATUS 
                    WHEN 10 THEN '#{218492}' 
                    WHEN 30 THEN '#{218493}' 
                    WHEN 40 THEN '#{218494}' 
                END AS IDSLASTATUS,
                WFP.FGSTATUS,
                CASE WFP.FGSTATUS 
                    WHEN 1 THEN '#{103131}' 
                    WHEN 2 THEN '#{107788}' 
                    WHEN 3 THEN '#{104230}' 
                    WHEN 4 THEN '#{100667}' 
                    WHEN 5 THEN '#{200712}' 
                END AS IDSITUATION,
                GNR.NMEVALRESULT,
                (SELECT
                    MAX(IDLEVEL) 
                FROM
                    GNSLACTRLHISTORY 
                WHERE
                    CDSLACONTROL=WFP.CDSLACONTROL 
                    AND FGCURRENT=1) AS IDLEVEL,
                WFP.IDPROCESSTYPE,
                WFP.IDREVISION,
                CASE 
                    WHEN SLACTRL.BNSLAFINISH IS NOT NULL THEN TO_TIMESTAMP(TO_CHAR(SEF_DTEND_WK_SECS_PERIOD(TO_DATE('1970-01-01',
                    'YYYY-MM-DD HH24:MI:SS'),
                    (SLACTRL.BNSLAFINISH / 1000) -10800,
                    -2),
                    'YYYY-MM-DD HH24:MI:SS'),
                    'YYYY-MM-DD HH24:MI:SS') 
                    ELSE NULL 
                END AS DTSLAFINISH,
                WFP.DTESTIMATEDFINISH + WFP.NRTIMEESTFINISH/1440 AS DTDEADLINEFIELD,
                TO_TIMESTAMP(TO_CHAR(WFP.DTSTART,
                'YYYY-MM-DD') || ' ' || WFP.TMSTART,
                'YYYY-MM-DD HH24:MI:SS') AS DTSTART,
                CASE 
                    WHEN WFP.DTFINISH IS NOT NULL THEN TO_TIMESTAMP(TO_CHAR(WFP.DTFINISH,
                    'YYYY-MM-DD') || ' ' || WFP.TMFINISH,
                    'YYYY-MM-DD HH24:MI:SS') 
                    ELSE NULL 
                END AS DTFINISH,
                T0_OUTER.T0__NMAPROBADOR_1,
                T0_OUTER.T0__CANTNORM_1,
                T0_OUTER.T0__NMELABORADOR_1,
                T0_OUTER.T0__FECHAPROBOLE_6,
                T0_OUTER.T0__FECHELABBOLE_6,
                T0_OUTER.T0__FECHINICWORK_6,
                T0_OUTER.T0__FECHEMISWSBOLE_1,
                T0_OUTER.T0__IDBOLETITU_1,
                T0_OUTER.T0__IDWF_1,
                T0_OUTER.T0__IDBOLETIN_1,
                T0_OUTER.T0__IDAPROBADOR_1,
                T0_OUTER.T0__MOTIRECH_2,
                T0_OUTER.T0__RESWEBCREBOL_1,
                T0_OUTER.T0__RESWEBDESBOL_1,
                T0_OUTER.T0__RESWEBSTATUS_1,
                T0_OUTER.T0__TITUBOLE_1,
			    T0_OUTER.SUBTITULO
            FROM
                WFPROCESS WFP 
            LEFT OUTER JOIN
                GNSLACONTROL SLACTRL 
                    ON WFP.CDSLACONTROL=SLACTRL.CDSLACONTROL 
            LEFT OUTER JOIN
                GNREVISIONSTATUS GNRS 
                    ON WFP.CDSTATUS=GNRS.CDREVISIONSTATUS 
            LEFT OUTER JOIN
                GNEVALRESULTUSED GNRUS 
                    ON GNRUS.CDEVALRESULTUSED=WFP.CDEVALRSLTPRIORITY 
            LEFT OUTER JOIN
                GNEVALRESULT GNR 
                    ON GNRUS.CDEVALRESULT=GNR.CDEVALRESULT 
            LEFT OUTER JOIN
                (
                    SELECT
                        FORMREG.CDASSOC,
                        T0.NMAPROBADOR AS T0__NMAPROBADOR_1,
                        T0.CANTNORM AS T0__CANTNORM_1,
                        T0.NMELABORADOR AS T0__NMELABORADOR_1,
                        T0.FECHAPROBOLE AS T0__FECHAPROBOLE_6,
                        T0.FECHELABBOLE AS T0__FECHELABBOLE_6,
                        T0.FECHINICWORK AS T0__FECHINICWORK_6,
                        T0.FECHEMISWSBOLE AS T0__FECHEMISWSBOLE_1,
                        T0.IDBOLETITU AS T0__IDBOLETITU_1,
                        T0.IDWF AS T0__IDWF_1,
                        T0.IDBOLETIN AS T0__IDBOLETIN_1,
                        T0.IDAPROBADOR AS T0__IDAPROBADOR_1,
                        T0.MOTIRECH AS T0__MOTIRECH_2,
                        T0.RESWEBCREBOL AS T0__RESWEBCREBOL_1,
                        T0.RESWEBDESBOL AS T0__RESWEBDESBOL_1,
                        T0.RESWEBSTATUS AS T0__RESWEBSTATUS_1,
                        T0.TITUBOLE AS T0__TITUBOLE_1,
				  		T0.SUBTBOLE AS SUBTITULO
                    FROM
                        GNASSOCFORMREG FORMREG 
                    INNER JOIN
                        DYNbolenorm T0 
                            ON (
                                FORMREG.OIDENTITYREG=T0.OID
                            )
                    ) T0_OUTER 
                        ON (
                            T0_OUTER.CDASSOC=WFP.CDASSOCREG
                        ) 
                INNER JOIN
                    (
                        SELECT
                            DISTINCT Z.IDOBJECT 
                        FROM
                            (SELECT
                                AUXWFP.IDOBJECT 
                            FROM
                                (SELECT
                                    WF.IDPROCESS,
                                    WF.CDACCESSLIST 
                                FROM
                                    WFPROCSECURITYLIST WF 
                                INNER JOIN
                                    ADTEAMUSER TM 
                                        ON WF.CDTEAM=TM.CDTEAM 
                                WHERE
                                    WF.FGACCESSTYPE=1 
                                    AND TM.CDUSER=8 
                                UNION
                                ALL SELECT
                                    WF.IDPROCESS,
                                    WF.CDACCESSLIST 
                                FROM
                                    WFPROCSECURITYLIST WF 
                                INNER JOIN
                                    ADUSERDEPTPOS UDP 
                                        ON WF.CDDEPARTMENT=UDP.CDDEPARTMENT 
                                WHERE
                                    WF.FGACCESSTYPE=2 
                                    AND UDP.CDUSER=8 
                                UNION
                                ALL SELECT
                                    WF.IDPROCESS,
                                    WF.CDACCESSLIST 
                                FROM
                                    WFPROCSECURITYLIST WF 
                                INNER JOIN
                                    ADUSERDEPTPOS UDP 
                                        ON WF.CDDEPARTMENT=UDP.CDDEPARTMENT 
                                        AND WF.CDPOSITION=UDP.CDPOSITION 
                                WHERE
                                    WF.FGACCESSTYPE=3 
                                    AND UDP.CDUSER=8 
                                UNION
                                ALL SELECT
                                    WF.IDPROCESS,
                                    WF.CDACCESSLIST 
                                FROM
                                    WFPROCSECURITYLIST WF 
                                INNER JOIN
                                    ADUSERDEPTPOS UDP 
                                        ON WF.CDPOSITION=UDP.CDPOSITION 
                                WHERE
                                    WF.FGACCESSTYPE=4 
                                    AND UDP.CDUSER=8 
                                UNION
                                ALL SELECT
                                    WF.IDPROCESS,
                                    WF.CDACCESSLIST 
                                FROM
                                    WFPROCSECURITYLIST WF 
                                WHERE
                                    WF.FGACCESSTYPE=5 
                                    AND WF.CDUSER=8 
                                UNION
                                ALL SELECT
                                    WF.IDPROCESS,
                                    WF.CDACCESSLIST 
                                FROM
                                    WFPROCSECURITYLIST WF 
                                WHERE
                                    WF.FGACCESSTYPE=6 
                                UNION
                                ALL SELECT
                                    WF.IDPROCESS,
                                    WF.CDACCESSLIST 
                                FROM
                                    WFPROCSECURITYLIST WF 
                                INNER JOIN
                                    ADUSERROLE RL 
                                        ON RL.CDROLE=WF.CDROLE 
                                WHERE
                                    WF.FGACCESSTYPE=7 
                                    AND RL.CDUSER=8 
                                UNION
                                ALL SELECT
                                    WF.IDPROCESS,
                                    WF.CDACCESSLIST 
                                FROM
                                    WFPROCSECURITYLIST WF 
                                INNER JOIN
                                    WFPROCESS WFP 
                                        ON WFP.IDOBJECT=WF.IDPROCESS 
                                WHERE
                                    WF.FGACCESSTYPE=30 
                                    AND WFP.CDUSERSTART=8 
                                UNION
                                ALL SELECT
                                    WF.IDPROCESS,
                                    WF.CDACCESSLIST 
                                FROM
                                    WFPROCSECURITYLIST WF 
                                INNER JOIN
                                    WFPROCESS WFP 
                                        ON WFP.IDOBJECT=WF.IDPROCESS 
                                INNER JOIN
                                    ADUSER US 
                                        ON US.CDUSER=WFP.CDUSERSTART 
                                WHERE
                                    WF.FGACCESSTYPE=31 
                                    AND US.CDLEADER=8
                            ) PERM 
                        INNER JOIN
                            WFPROCSECURITYCTRL GNASSOC 
                                ON (
                                    GNASSOC.CDACCESSLIST=PERM.CDACCESSLIST 
                                    AND GNASSOC.IDPROCESS=PERM.IDPROCESS
                                ) 
                        INNER JOIN
                            WFPROCESS AUXWFP 
                                ON GNASSOC.IDPROCESS=AUXWFP.IDOBJECT 
                        WHERE
                            GNASSOC.CDACCESSROLEFIELD IN (
                                501
                            ) 
                            AND AUXWFP.FGSTATUS <= 5 
                            AND (
                                AUXWFP.FGMODELWFSECURITY IS NULL 
                                OR AUXWFP.FGMODELWFSECURITY=0
                            ) 
                        UNION
                        ALL SELECT
                            PERM99.IDOBJECT 
                        FROM
                            (SELECT
                                WFP.IDOBJECT 
                            FROM
                                (SELECT
                                    PP.CDPROC,
                                    PP.CDACCESSLIST 
                                FROM
                                    PMPROCACCESSLIST PP 
                                INNER JOIN
                                    ADTEAMUSER TM 
                                        ON PP.CDTEAM=TM.CDTEAM 
                                WHERE
                                    PP.FGACCESSTYPE=1 
                                    AND TM.CDUSER=8 
                                UNION
                                ALL SELECT
                                    PP.CDPROC,
                                    PP.CDACCESSLIST 
                                FROM
                                    PMPROCACCESSLIST PP 
                                INNER JOIN
                                    ADUSERDEPTPOS UDP 
                                        ON PP.CDDEPARTMENT=UDP.CDDEPARTMENT 
                                WHERE
                                    PP.FGACCESSTYPE=2 
                                    AND UDP.CDUSER=8 
                                UNION
                                ALL SELECT
                                    PP.CDPROC,
                                    PP.CDACCESSLIST 
                                FROM
                                    PMPROCACCESSLIST PP 
                                INNER JOIN
                                    ADUSERDEPTPOS UDP 
                                        ON (
                                            PP.CDDEPARTMENT=UDP.CDDEPARTMENT 
                                            AND PP.CDPOSITION=UDP.CDPOSITION
                                        ) 
                                WHERE
                                    PP.FGACCESSTYPE=3 
                                    AND UDP.CDUSER=8 
                                UNION
                                ALL SELECT
                                    PP.CDPROC,
                                    PP.CDACCESSLIST 
                                FROM
                                    PMPROCACCESSLIST PP 
                                INNER JOIN
                                    ADUSERDEPTPOS UDP 
                                        ON PP.CDPOSITION=UDP.CDPOSITION 
                                WHERE
                                    PP.FGACCESSTYPE=4 
                                    AND UDP.CDUSER=8 
                                UNION
                                ALL SELECT
                                    PP.CDPROC,
                                    PP.CDACCESSLIST 
                                FROM
                                    PMPROCACCESSLIST PP 
                                WHERE
                                    PP.FGACCESSTYPE=5 
                                    AND PP.CDUSER=8 
                                UNION
                                ALL SELECT
                                    PP.CDPROC,
                                    PP.CDACCESSLIST 
                                FROM
                                    PMPROCACCESSLIST PP 
                                WHERE
                                    PP.FGACCESSTYPE=6 
                                UNION
                                ALL SELECT
                                    PP.CDPROC,
                                    PP.CDACCESSLIST 
                                FROM
                                    PMPROCACCESSLIST PP 
                                INNER JOIN
                                    ADUSERROLE RL 
                                        ON RL.CDROLE=PP.CDROLE 
                                WHERE
                                    PP.FGACCESSTYPE=7 
                                    AND RL.CDUSER=8
                            ) PERM1 
                        INNER JOIN
                            PMPROCSECURITYCTRL GNASSOC 
                                ON (
                                    PERM1.CDACCESSLIST=GNASSOC.CDACCESSLIST 
                                    AND PERM1.CDPROC=GNASSOC.CDPROC
                                ) 
                        INNER JOIN
                            PMACCESSROLEFIELD GNCTRL 
                                ON GNASSOC.CDACCESSROLEFIELD=GNCTRL.CDACCESSROLEFIELD 
                        INNER JOIN
                            PMACTIVITY OBJ 
                                ON GNASSOC.CDPROC=OBJ.CDACTIVITY 
                        INNER JOIN
                            WFPROCESS WFP 
                                ON WFP.CDPROCESSMODEL=PERM1.CDPROC 
                        WHERE
                            GNCTRL.CDRELATEDFIELD IN (
                                501
                            ) 
                            AND (
                                OBJ.FGUSETYPEACCESS=0 
                                OR OBJ.FGUSETYPEACCESS IS NULL
                            ) 
                            AND WFP.FGMODELWFSECURITY=1 
                            AND WFP.FGSTATUS <= 5 
                        UNION
                        ALL SELECT
                            PERM2.IDOBJECT 
                        FROM
                            (SELECT
                                WFP.IDOBJECT,
                                PP.CDPROC,
                                PP.CDACCESSLIST 
                            FROM
                                PMPROCACCESSLIST PP 
                            INNER JOIN
                                WFPROCESS WFP 
                                    ON WFP.CDPROCESSMODEL=PP.CDPROC 
                            WHERE
                                PP.FGACCESSTYPE=30 
                                AND WFP.CDUSERSTART=8 
                                AND WFP.FGMODELWFSECURITY=1 
                                AND WFP.FGSTATUS <= 5 
                            UNION
                            ALL SELECT
                                WFP.IDOBJECT,
                                PP.CDPROC,
                                PP.CDACCESSLIST 
                            FROM
                                PMPROCACCESSLIST PP 
                            INNER JOIN
                                WFPROCESS WFP 
                                    ON WFP.CDPROCESSMODEL=PP.CDPROC 
                            INNER JOIN
                                ADUSER US 
                                    ON US.CDUSER=WFP.CDUSERSTART 
                            WHERE
                                PP.FGACCESSTYPE=31 
                                AND US.CDLEADER=8 
                                AND WFP.FGMODELWFSECURITY=1 
                                AND WFP.FGSTATUS <= 5
                        ) PERM2 
                    INNER JOIN
                        PMPROCSECURITYCTRL GNASSOC 
                            ON (
                                PERM2.CDACCESSLIST=GNASSOC.CDACCESSLIST 
                                AND PERM2.CDPROC=GNASSOC.CDPROC
                            ) 
                    INNER JOIN
                        PMACCESSROLEFIELD GNCTRL 
                            ON GNASSOC.CDACCESSROLEFIELD=GNCTRL.CDACCESSROLEFIELD 
                    INNER JOIN
                        PMACTIVITY OBJ 
                            ON GNASSOC.CDPROC=OBJ.CDACTIVITY 
                    WHERE
                        GNCTRL.CDRELATEDFIELD IN (
                            501
                        ) 
                        AND (
                            OBJ.FGUSETYPEACCESS=0 
                            OR OBJ.FGUSETYPEACCESS IS NULL
                        )) PERM99 
                UNION
                ALL SELECT
                    PERM.IDOBJECT 
                FROM
                    (SELECT
                        WFP.IDOBJECT 
                    FROM
                        (SELECT
                            PM.CDACTTYPE,
                            PM.CDACCESSLIST 
                        FROM
                            PMACTTYPESECURLIST PM 
                        INNER JOIN
                            ADTEAMUSER TM 
                                ON PM.CDTEAM=TM.CDTEAM 
                        WHERE
                            PM.FGACCESSTYPE=1 
                            AND TM.CDUSER=8 
                        UNION
                        ALL SELECT
                            PM.CDACTTYPE,
                            PM.CDACCESSLIST 
                        FROM
                            PMACTTYPESECURLIST PM 
                        INNER JOIN
                            ADUSERDEPTPOS UDP 
                                ON PM.CDDEPARTMENT=UDP.CDDEPARTMENT 
                        WHERE
                            PM.FGACCESSTYPE=2 
                            AND UDP.CDUSER=8 
                        UNION
                        ALL SELECT
                            PM.CDACTTYPE,
                            PM.CDACCESSLIST 
                        FROM
                            PMACTTYPESECURLIST PM 
                        INNER JOIN
                            ADUSERDEPTPOS UDP 
                                ON PM.CDDEPARTMENT=UDP.CDDEPARTMENT 
                                AND PM.CDPOSITION=UDP.CDPOSITION 
                        WHERE
                            PM.FGACCESSTYPE=3 
                            AND UDP.CDUSER=8 
                        UNION
                        ALL SELECT
                            PM.CDACTTYPE,
                            PM.CDACCESSLIST 
                        FROM
                            PMACTTYPESECURLIST PM 
                        INNER JOIN
                            ADUSERDEPTPOS UDP 
                                ON PM.CDPOSITION=UDP.CDPOSITION 
                        WHERE
                            PM.FGACCESSTYPE=4 
                            AND UDP.CDUSER=8 
                        UNION
                        ALL SELECT
                            PM.CDACTTYPE,
                            PM.CDACCESSLIST 
                        FROM
                            PMACTTYPESECURLIST PM 
                        WHERE
                            PM.FGACCESSTYPE=5 
                            AND PM.CDUSER=8 
                        UNION
                        ALL SELECT
                            PM.CDACTTYPE,
                            PM.CDACCESSLIST 
                        FROM
                            PMACTTYPESECURLIST PM 
                        WHERE
                            PM.FGACCESSTYPE=6 
                        UNION
                        ALL SELECT
                            PM.CDACTTYPE,
                            PM.CDACCESSLIST 
                        FROM
                            PMACTTYPESECURLIST PM 
                        INNER JOIN
                            ADUSERROLE RL 
                                ON RL.CDROLE=PM.CDROLE 
                        WHERE
                            PM.FGACCESSTYPE=7 
                            AND RL.CDUSER=8
                    ) PERM1 
                INNER JOIN
                    PMACTTYPESECURCTRL GNASSOC 
                        ON (
                            PERM1.CDACCESSLIST=GNASSOC.CDACCESSLIST 
                            AND PERM1.CDACTTYPE=GNASSOC.CDACTTYPE
                        ) 
                INNER JOIN
                    PMACCESSROLEFIELD GNCTRL 
                        ON GNASSOC.CDACCESSROLEFIELD=GNCTRL.CDACCESSROLEFIELD 
                INNER JOIN
                    PMACCESSROLEFIELD GNCTRL_F 
                        ON GNCTRL.CDRELATEDFIELD=GNCTRL_F.CDACCESSROLEFIELD 
                INNER JOIN
                    PMACTIVITY PMA 
                        ON PERM1.CDACTTYPE=PMA.CDACTTYPE 
                INNER JOIN
                    WFPROCESS WFP 
                        ON PMA.CDACTIVITY=WFP.CDPROCESSMODEL 
                WHERE
                    GNCTRL_F.CDRELATEDFIELD IN (
                        501
                    ) 
                    AND WFP.FGSTATUS <= 5 
                    AND PMA.FGUSETYPEACCESS=1 
                    AND WFP.FGMODELWFSECURITY=1 
                UNION
                ALL SELECT
                    WFP.IDOBJECT 
                FROM
                    (SELECT
                        PM.CDACTTYPE,
                        PM.CDACCESSLIST 
                    FROM
                        PMACTTYPESECURLIST PM 
                    INNER JOIN
                        PMACTIVITY PMA 
                            ON PM.CDACTTYPE=PMA.CDACTTYPE 
                    WHERE
                        PM.FGACCESSTYPE=8 
                        AND PMA.CDCREATEDBY=8 
                    UNION
                    ALL SELECT
                        PM.CDACTTYPE,
                        PM.CDACCESSLIST 
                    FROM
                        PMACTTYPESECURLIST PM 
                    INNER JOIN
                        PMACTIVITY PMA 
                            ON PM.CDACTTYPE=PMA.CDACTTYPE 
                    INNER JOIN
                        ADUSERDEPTPOS DEP1 
                            ON DEP1.CDUSER=PMA.CDCREATEDBY 
                    INNER JOIN
                        ADUSERDEPTPOS DEP2 
                            ON DEP2.CDDEPARTMENT=DEP1.CDDEPARTMENT 
                    WHERE
                        PM.FGACCESSTYPE=9 
                        AND DEP2.CDUSER=8 
                    UNION
                    ALL SELECT
                        PM.CDACTTYPE,
                        PM.CDACCESSLIST 
                    FROM
                        PMACTTYPESECURLIST PM 
                    INNER JOIN
                        PMACTIVITY PMA 
                            ON PM.CDACTTYPE=PMA.CDACTTYPE 
                    INNER JOIN
                        ADUSERDEPTPOS DEP1 
                            ON DEP1.CDUSER=PMA.CDCREATEDBY 
                    INNER JOIN
                        ADUSERDEPTPOS DEP2 
                            ON (
                                DEP2.CDDEPARTMENT=DEP1.CDDEPARTMENT 
                                AND DEP2.CDPOSITION=DEP1.CDPOSITION
                            ) 
                    WHERE
                        PM.FGACCESSTYPE=10 
                        AND DEP2.CDUSER=8 
                    UNION
                    ALL SELECT
                        PM.CDACTTYPE,
                        PM.CDACCESSLIST 
                    FROM
                        PMACTTYPESECURLIST PM 
                    INNER JOIN
                        PMACTIVITY PMA 
                            ON PM.CDACTTYPE=PMA.CDACTTYPE 
                    INNER JOIN
                        ADUSERDEPTPOS DEP1 
                            ON DEP1.CDUSER=PMA.CDCREATEDBY 
                    INNER JOIN
                        ADUSERDEPTPOS DEP2 
                            ON DEP2.CDPOSITION=DEP1.CDPOSITION 
                    WHERE
                        PM.FGACCESSTYPE=11 
                        AND DEP2.CDUSER=8 
                    UNION
                    ALL SELECT
                        PM.CDACTTYPE,
                        PM.CDACCESSLIST 
                    FROM
                        PMACTTYPESECURLIST PM 
                    INNER JOIN
                        PMACTIVITY PMA 
                            ON PM.CDACTTYPE=PMA.CDACTTYPE 
                    INNER JOIN
                        ADUSER US 
                            ON US.CDUSER=PMA.CDCREATEDBY 
                    WHERE
                        PM.FGACCESSTYPE=12 
                        AND US.CDLEADER=8
                ) PERM2 
            INNER JOIN
                PMACTTYPESECURCTRL GNASSOC 
                    ON (
                        PERM2.CDACCESSLIST=GNASSOC.CDACCESSLIST 
                        AND PERM2.CDACTTYPE=GNASSOC.CDACTTYPE
                    ) 
            INNER JOIN
                PMACCESSROLEFIELD GNCTRL 
                    ON GNASSOC.CDACCESSROLEFIELD=GNCTRL.CDACCESSROLEFIELD 
            INNER JOIN
                PMACCESSROLEFIELD GNCTRL_F 
                    ON GNCTRL.CDRELATEDFIELD=GNCTRL_F.CDACCESSROLEFIELD 
            INNER JOIN
                PMACTIVITY PMA 
                    ON PERM2.CDACTTYPE=PMA.CDACTTYPE 
            INNER JOIN
                WFPROCESS WFP 
                    ON PMA.CDACTIVITY=WFP.CDPROCESSMODEL 
            WHERE
                GNCTRL_F.CDRELATEDFIELD IN (
                    501
                ) 
                AND WFP.FGSTATUS <= 5 
                AND PMA.FGUSETYPEACCESS=1 
                AND WFP.FGMODELWFSECURITY=1 
            UNION
            ALL SELECT
                PERM3.IDOBJECT 
            FROM
                (SELECT
                    PM.CDACTTYPE,
                    PM.CDACCESSLIST,
                    WFP.IDOBJECT 
                FROM
                    PMACTTYPESECURLIST PM 
                INNER JOIN
                    PMACTIVITY PMA 
                        ON PM.CDACTTYPE=PMA.CDACTTYPE 
                INNER JOIN
                    WFPROCESS WFP 
                        ON PMA.CDACTIVITY=WFP.CDPROCESSMODEL 
                WHERE
                    PM.FGACCESSTYPE=30 
                    AND WFP.CDUSERSTART=8 
                    AND WFP.FGSTATUS <= 5 
                    AND WFP.FGMODELWFSECURITY=1 
                UNION
                ALL SELECT
                    PM.CDACTTYPE,
                    PM.CDACCESSLIST,
                    WFP.IDOBJECT 
                FROM
                    PMACTTYPESECURLIST PM 
                INNER JOIN
                    PMACTIVITY PMA 
                        ON PM.CDACTTYPE=PMA.CDACTTYPE 
                INNER JOIN
                    WFPROCESS WFP 
                        ON PMA.CDACTIVITY=WFP.CDPROCESSMODEL 
                INNER JOIN
                    ADUSER US 
                        ON US.CDUSER=WFP.CDUSERSTART 
                WHERE
                    PM.FGACCESSTYPE=31 
                    AND US.CDLEADER=8 
                    AND WFP.FGSTATUS <= 5 
                    AND WFP.FGMODELWFSECURITY=1
            ) PERM3 
        INNER JOIN
            PMACTTYPESECURCTRL GNASSOC 
                ON (
                    PERM3.CDACCESSLIST=GNASSOC.CDACCESSLIST 
                    AND PERM3.CDACTTYPE=GNASSOC.CDACTTYPE
                ) 
        INNER JOIN
            PMACCESSROLEFIELD GNCTRL 
                ON GNASSOC.CDACCESSROLEFIELD=GNCTRL.CDACCESSROLEFIELD 
        INNER JOIN
            PMACCESSROLEFIELD GNCTRL_F 
                ON GNCTRL.CDRELATEDFIELD=GNCTRL_F.CDACCESSROLEFIELD 
        INNER JOIN
            PMACTIVITY PMA 
                ON PERM3.CDACTTYPE=PMA.CDACTTYPE 
        WHERE
            GNCTRL_F.CDRELATEDFIELD IN (
                501
            ) 
            AND PMA.FGUSETYPEACCESS=1) PERM 
    UNION
    ALL SELECT
        AUXWFP.IDOBJECT 
    FROM
        WFPROCESS AUXWFP 
    INNER JOIN
        WFPROCSECURITYLIST WFLIST 
            ON (
                AUXWFP.IDOBJECT=WFLIST.IDPROCESS
            ) 
    INNER JOIN
        WFPROCSECURITYCTRL WFCTRL 
            ON (
                WFLIST.CDACCESSLIST=WFCTRL.CDACCESSLIST 
                AND WFLIST.IDPROCESS=WFCTRL.IDPROCESS
            ) 
    WHERE
        WFCTRL.CDACCESSROLEFIELD IN (
            501
        ) 
        AND WFLIST.CDUSER=8 
        AND WFLIST.FGACCESSTYPE=5 
        AND WFLIST.FGACCESSEXCEPTION=1 
        AND AUXWFP.FGSTATUS <= 5
) Z
) MYPERM 
ON (
    WFP.IDOBJECT=MYPERM.IDOBJECT
) 
WHERE
WFP.FGSTATUS <= 5 
AND WFP.CDPRODAUTOMATION NOT IN (
160, 202, 275
) 
AND WFP.CDPROCESSMODEL=12101
) TEMPTB0
) TEMPTB1