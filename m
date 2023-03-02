Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAD6A873F
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 17:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCBQrn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 11:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjCBQrg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 11:47:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DC34AFFE;
        Thu,  2 Mar 2023 08:47:29 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322FCmhg028183;
        Thu, 2 Mar 2023 16:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ds3EDTffAzMh8JEz+W8FxnAH9vvZstp6bSSlX0uMyow=;
 b=m7K1RJRi99TYbSaLE/8j3fKo6yjHAc8VEr8ug3jDKW0LzcSi5mm9QF4MtuLGfQIHBcaG
 2YQ1LrsTdFoa4i0twn4zvLUhKVZhSI5cGrT8b4BmX8wNJSF2UzmS+o9O6KzQcmH2WwI9
 n9M8dJvtKN6siAkdsgiTzdE5r9bJcPEK+lnj/ueJgr1U/t320uvDI8JkO2DeDJ0nJQrW
 ejQQvL1nLCmnDMfvuAH2N/CVDlZxVuryDu5auQWaJL6IpiTji1c1vnTsmqAbxmx/AZ90
 AwllWZjS8TyHd2ydW7UEPcsz1Bm/ywjd7xNPGB9xdztCLpuC7rMQ+JNCOHaNsdBC0r5p qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wvfqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:47:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322FUguS000581;
        Thu, 2 Mar 2023 16:46:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sa9sff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:46:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVt5Ptxike8Ha7tBmgss839EpFzh9Fzz2LuwHU53ozu+CNq/H2bzePBbIVZv78ynotzIP/htijdwaK/HzltiRME9/ofv0jpgIimPqu5PYiObKte3+shz/gYtslbLAOF3OvTW0//0WxLUCbgvT/iK4TfljJWfW6m/PvzFjesUUYvySY1LyNif7TC7iizGVp83v3PH3eAjJo8WpTqz/c4bwVaJ7SLrAteyRgGZhe9NQ7epxdUgCLqAgQDths5yHp2JSmY0VBwWnfyAm2yWMgYpM8xo/7nMVJTlIa2c0WDoiB4MKwIrpZWOI6OhJlR1Kv/j4sX14GxZbQWS1ccdSUyK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds3EDTffAzMh8JEz+W8FxnAH9vvZstp6bSSlX0uMyow=;
 b=MW8aSDJQo8IqrzF58cJsixzbA+5wxnCbA1pFQOaU45BgPFsYwUb8JdWPwbE6KUTeLCG+5EfuTp/xpAEZ45k4sIdnxdZXgKlqI6eIcWYlEOUYeCZvjAgSk3hYX33Wo+x6YSIicThj7X1wGd4LgK4iDasTo4E3mhaUukkpErUjAC1x2H8yb4VpX1alngC0ydKcTeQglURB8XatKjjJOLaQri2eEFw4KxxGIMp2G4MwAwW7W+GJof+JAoberzS2cBCc/cq13j7+aupyMdoROmAzG/H1h5ykEa5iGkGqqsmVOs6PZjXltYFcEZHygbTfzezIxgbJXj35uH1P4ZQaHL6sjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds3EDTffAzMh8JEz+W8FxnAH9vvZstp6bSSlX0uMyow=;
 b=Cm4iYOE9uyU5NwUM81rKjBCVlYxBgpbmhWULpEhwIW/jlMEj117iUYmB6OXCJ5knpLLJfv7/G108AFwZAS4OWk70wvXzm5t8VXiccYhLT2CG6jX9qKi6b+0AfE5zSsaBCJFeciciUbQ76Rwmlkeg573MTgkwZHcpzzZXEFw6XMA=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5150.namprd10.prod.outlook.com (2603:10b6:5:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 16:46:57 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 16:46:57 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 3/6] KEYS: X.509: Parse Basic Constraints for CA
Date:   Thu,  2 Mar 2023 11:46:49 -0500
Message-Id: <20230302164652.83571-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230302164652.83571-1-eric.snowberg@oracle.com>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::15) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7999d2-f1d3-46ca-a7d6-08db1b3dbc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtDH1qtf14yKF5Vg1UXVv66A5o+xRjfM/Dxlzo+tOXRVUloEsrsYw6USfanWbel0P6vprdpnQdSzJ1BPc8s57FXHDPekDkXXinmNMzRUUOsVe/x/jKxuhNjnKLwgYAfhU6fpCO5dUSKEEHkZLS7TmAX9m3bKgRuadz3SKYXrPPfP0zhn0fcoIif6l0MFARxakPv0nAYRQ2FAzHxlmCVN8ezZbqEtSjT86/oJBrSOavIUvqMJ4Hq5nXfunZQMm9KkX2/OdOML6vwkIDbYTVULBytUJUaMq7VQbOionncIHAZ60uPQ9kptBVtta3xLWlUuBUF4yRju8zW1BOzf/vcAUMClM1l2a9QSbtVOXRUvHF60KkXG02qstZiuW4dCHzjYRjK25RsVXmtn78gRxAZmwDefh8Uf8/loJToFwATC9oI3g2WnvO7yEhTtvH8ViBxG+i801oPC8l2P19PYLPBCsSOmoAD/2yMpGfj4qVzCEmBAbRK4DH8yc782zFpgyje0pjWD3SiDMCAbdxxbTI2W1TZAxIDC5XxlNsx9cWiwg+76rjhM/2SW8ayPk4nuDgqTt03dqtfVL/W5LdfWjHn8JKW53YpcJ2rNiKK/U3wDZNqWFTSjJD9o2XORHYkqwi3X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(36756003)(86362001)(8676002)(41300700001)(66556008)(66476007)(5660300002)(7416002)(8936002)(4326008)(2906002)(44832011)(38100700002)(966005)(6486002)(316002)(478600001)(6666004)(66946007)(6512007)(1076003)(6506007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DlZgxoc+SRJQ+sHa8CMa1ptH+dmwnUEMqlwtW39Q4Nw65RI4fvcqByts812P?=
 =?us-ascii?Q?Jn0hZT3r8AjJetIMbkPg8YpTkvDGlpvsDlSRqnMRJs28Oc7IPWk9ott3B5Mu?=
 =?us-ascii?Q?CdRzhuycTJhMY3ZgJPttSXoKwqFtSdSrAvjZ8A8pPdm36ML/u/a+YlzoEMnV?=
 =?us-ascii?Q?hrou6Uf7wPXiKWfUqq4ULQ0/E4ngspjulTvfe7MJNu3IH8cNFBW2DvtkZswY?=
 =?us-ascii?Q?m7RMuhEOpmObM0cJL8fjmwrE1KBAoujj32481rPjju/klKQ9BY1pmLLhA5tM?=
 =?us-ascii?Q?cJQM4lZe9nboCEBuTQdTevtQoCHZSA2lm/5giQ/SS03B45IFQAuqkPoe5pBf?=
 =?us-ascii?Q?HWTDHcw6atuV00rIX9E9WgWdpFK5u2UfPT2csxGdImxmhfx7iOyr0nu+po1X?=
 =?us-ascii?Q?R6xslX90zP2fZvXbPkLZToJUCfIYVZtvApmaqWQawzMa2vCt8szcygPD9NL5?=
 =?us-ascii?Q?iYrZMzzBT8QC3WUJD+yXn4+38FZkD5qmr3M/hK0wGwEub9pVqWqsCrsqqhFL?=
 =?us-ascii?Q?xY/7S2d20v3AIn/cktQ802W32qhXH4wPsqvdZwxpHOG1LT4qzfThCSU8eqq0?=
 =?us-ascii?Q?o4Q2MTTwHIW56gss/go6S4JvSA9HtT+YUPzuUMfFeOK474jPFE2RTOAjgCBp?=
 =?us-ascii?Q?pexyKwdohc3TjXeoRRxC3bE3f/BL05BFxWoSOonOwJeaCpKbheXFUUYerMKa?=
 =?us-ascii?Q?QoKyB7Xf37lal83E9w5+N519RBSAC/3ROU0IOGOO7ILjKr5ROV0tVvhtqSVo?=
 =?us-ascii?Q?+E4yBdUYKjXoAhvxyesK6ti/iPRwHQgQuM1D07ARNts1Bw2gfl6iOd0CHkY0?=
 =?us-ascii?Q?sxSWmw0iCUkhqyWW8mFWJk1xt3O1hABd7lWdlenBJAMF3hzoSoXnHpaUZLr7?=
 =?us-ascii?Q?Hu0fu/3+clhirsDosdFHH7bt39jYR3KUJjAhBBw4K59L799f3Ck6S3qIi8ND?=
 =?us-ascii?Q?8Oc31ZQ3YogyZJXzPhSXNRoUFm4IwfPyZN/LOCJSu7Nu15UOe8VHnvB4G2M6?=
 =?us-ascii?Q?B/sizMlFqlxZL0tyTEg1pwDRRsO5texGKLnK9esSj9svjpUM3ePfE1bxBiiY?=
 =?us-ascii?Q?C3b5mfEk1XP/Rs2Ts/t5n/Nl9K4vPsDQ7DH3RMzFcJoTT4LUMb7h9UTlaQIQ?=
 =?us-ascii?Q?EFpeLk+5EAlQBRXzYvS6hkDsUZvlspF6OewXWhUFSN+2sVW6abSzSLVCdRaE?=
 =?us-ascii?Q?CYBi6uS1CEYJIbKPFeIxiULawwwIVNnBc/XzSCixFbvpLMYgKF1MyOIKS1yh?=
 =?us-ascii?Q?jZa5qDvFthDs/IMBQaCq6wKZXGuHUSZiBlIYlBbLVgIeLJ0eKnmmRvlDDDev?=
 =?us-ascii?Q?IloN6Dm/O5D/8nbNi+Vd+W8Ar/6uNPBjKZwEJGYLuc82RGbtBafZ1I8VAb8s?=
 =?us-ascii?Q?otsCUE/iIru3nNFEbi14kM0ycQn/sWkf+EzllRVywUUHN4g85GVfDYVNIqIe?=
 =?us-ascii?Q?Usz+oP4gaf7MQvlRCxRa1JzpQj3f1Zf7+WWdaZvY+9jgnMWZYdlg0CBHmP4s?=
 =?us-ascii?Q?NK2/k/MX3IBabttoYr2e1SbVhvT53q0Vsk14J8Fofr7sqIzTyk8NZf5WUShX?=
 =?us-ascii?Q?4Sxe+84zR4ewfC3dR/4BxHH1xyprb+v9ws314AcKOoyLZ45y/CRR9/IqXrAR?=
 =?us-ascii?Q?sQTVTDHwPEkEIKPxlOcyrKI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jMmgT7Um/c/Awyb64mMHnHcgM5mFN+s2HM31ARHxkJChFv//lR+s4+xyj9Eo?=
 =?us-ascii?Q?bICiKu2pIwPjn6QYq3BE7612jw3ciVk9eSf/NGEKSzQFgiK5ScFOyGH8mbfI?=
 =?us-ascii?Q?wMJuv+dfrX1X73KW2ynAtRBQaQb2SHd+GQHvbKwJvYrmzMG654BEufqbv6Ow?=
 =?us-ascii?Q?T5pQ9eOW8CYLgzf9JAKWgwErYYkF0c7IE8lTywc0qcQ2f+CyihRM3pUaGnU4?=
 =?us-ascii?Q?7V7baDDjg2GwvhS+4SWyK2iJhXdjxQNp7tuLh0dSuNfMLvQmAk5BO0mvgyWJ?=
 =?us-ascii?Q?gkxAi8Lj+O8poZAT/HKwY9mrpwcBhWkRfdm4m17fXUuUmgjjhaM5f4PzYlIc?=
 =?us-ascii?Q?VthI33wFy0ycmVpHDaGkpu7BXdP8lI7c5LjeLh8u12698WvOR5jhSWKqj8+7?=
 =?us-ascii?Q?C8cMsTN1ylI6GfVxkVPibisFvfEyg9EmPvKj0fZHjN3fZMH1K9+xV1M4YymJ?=
 =?us-ascii?Q?lGwDrGlW+sQPHU44pWk5SYW8UNj+tCAr3ADOs65z38sWbMsY3gRTpMnDiEGH?=
 =?us-ascii?Q?HPqrX/Xx6T/SKScDl+f8sk1NDuFX5fp3w7TEFbtpaI9scIrMbMoqKmbra+0u?=
 =?us-ascii?Q?oODpsUTS/oLZLECYKEzVe7Fy/H0iRKPygpb0RzPa8YyjTOdiX91Q9XHQyDGM?=
 =?us-ascii?Q?Cvo+0nC9qo9sliB+xdzI8ZXfxTa5dt/+EYcgqL8IRTpbdt5Z8splsjBWvMgI?=
 =?us-ascii?Q?0Q8tI5JY94qNOfCQt0RxmwxPPai4X4xI7p8MS+UsIwCo74mIUwnJQIWogMFi?=
 =?us-ascii?Q?tMa2BmaHUux7U0fp2DVA4UyYikEwP8Gt3X9b/qaBT1f3j/ek/tq18Kb+9xTD?=
 =?us-ascii?Q?HuDTM9rbKpcgiCYk6uQJJBjJk+yuxOnvFfZZttXZMy69RO2PCk6TBs+0McFv?=
 =?us-ascii?Q?8q9tZr7saUHd6BgEreNI/wWEFR9D+LcmoWzZK4RnmIplCkie3WZPZwD64ROF?=
 =?us-ascii?Q?Ix2NbCWveSIH4Y0MNUDotrQEGnnNyHeY2hsvHMsIAp4r4A5eMKDFT855YNsk?=
 =?us-ascii?Q?bmbfF3u1onu66Ltyb50Pzb2H5Hxmxoje6vLCnqk7QiV3wUjqMexS0NmTtdG4?=
 =?us-ascii?Q?ot3dVf2R/zCh32gwQmpl3VjL1J+aaVwEZo6fAr6otYLDe+D0I4p1/FasxsJG?=
 =?us-ascii?Q?HomlzaLY+4821A1fXrfl6f5Z7o0ShoAYcEBK4CG3SGNQT7RGGQfYKvM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7999d2-f1d3-46ca-a7d6-08db1b3dbc4b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:46:57.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wMRyb66OFQyi70WfzCewRZM0HogrdQENiDawkbArdIFCp1yWAugRmLQn0f4L4PwI4kCj5DvOzhMGI3p6aaOxdpcSrvmya4mpd5ADiCbUCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_10,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020146
X-Proofpoint-GUID: 0qX1nu4vHPoXAgJg-1qMkVj_Xg0j0jkh
X-Proofpoint-ORIG-GUID: 0qX1nu4vHPoXAgJg-1qMkVj_Xg0j0jkh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Parse the X.509 Basic Constraints.  The basic constraints extension
identifies whether the subject of the certificate is a CA.

BasicConstraints ::= SEQUENCE {
        cA                      BOOLEAN DEFAULT FALSE,
        pathLenConstraint       INTEGER (0..MAX) OPTIONAL }

If the CA is true, store it in the public_key.  This will be used
in a follow on patch that requires knowing if the public key is a CA.

Link: https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.9
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 22 ++++++++++++++++++++++
 include/crypto/public_key.h               |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 7a9b084e2043..77547d4bd94d 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -586,6 +586,28 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_basicConstraints) {
+		/*
+		 * Get hold of the basicConstraints
+		 * v[1] is the encoding size
+		 *	(Expect 0x2 or greater, making it 1 or more bytes)
+		 * v[2] is the encoding type
+		 *	(Expect an ASN1_BOOL for the CA)
+		 * v[3] is the contents of the ASN1_BOOL
+		 *      (Expect 1 if the CA is TRUE)
+		 * vlen should match the entire extension size
+		 */
+		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
+			return -EBADMSG;
+		if (vlen < 2)
+			return -EBADMSG;
+		if (v[1] != vlen - 2)
+			return -EBADMSG;
+		if (vlen >= 4 && v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
+			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_CA;
+		return 0;
+	}
+
 	return 0;
 }
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 6d61695e1cde..c401762850f2 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -28,6 +28,8 @@ struct public_key {
 	bool key_is_private;
 	const char *id_type;
 	const char *pkey_algo;
+	unsigned long key_eflags;	/* key extension flags */
+#define KEY_EFLAG_CA		0	/* set if the CA basic constraints is set */
 };
 
 extern void public_key_free(struct public_key *key);
-- 
2.27.0

