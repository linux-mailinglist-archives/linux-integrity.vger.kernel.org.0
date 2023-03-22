Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B66C5067
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Mar 2023 17:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCVQUs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Mar 2023 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCVQUq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Mar 2023 12:20:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979143B3C5;
        Wed, 22 Mar 2023 09:20:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCY2A2018781;
        Wed, 22 Mar 2023 16:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ds3EDTffAzMh8JEz+W8FxnAH9vvZstp6bSSlX0uMyow=;
 b=aoYyvOS5AiQYALcxB1825xs3nAICdePY+llh0tJc4o2Yayde/zX5RAl2iiXhmgEQklVs
 eufyoRgPd55+T0LpEs1Cq0G/DGPQ80/ShVaA9EIVGPAONb+fAe4kM5rttpQah7Lx5Cbx
 RUKfSeOJ0Qh2AcLI9Z+/S+F40e25HFg0x/WD/zOLXTShP7esmNH8CQy8bXRhcdsp67GS
 g72+eklSvvqzuT57FACr2uUa8h0kWhdSpO8pyJzhUzwsS6cW5xLalQDI213uO1G15Vb6
 H5MEBcKPqhJJPHEcwzxXca78hYBepIiTy/nGlefTauj2+ljtkAUegZG7VRhkmDvK6C8p dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdsb31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MFcomi019003;
        Wed, 22 Mar 2023 16:20:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pg4gj1w1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjZAbOKzRccws6mCz1EEzUfiqX1do5rcIkLXQYtmwJarroclsZ3fMRxxl5/gfezwFJvI3H6WTjFMWOfEx5SQempqzsKDQ1mrOOwpVBcYGU+SQynVlWhRnyvyEyt060Cpv0dulA+RiYeGZbwy9ste0BDvQFGveEmu1oZk85z+UQXC8KKEC4KVjrOci1j5D0GgbEwcJzAaxWO2V0UfxvU8YbLp9LcJwUtb20eBTQKKtWvVPMADELTmA9HUDbrCKTj0wBXqc1V74bS/AtxxDIA87QzL5zgxUEgaIvmqByyLU0lI1Y0SMnspqxXaWDesu3ka4fHJskwgdXKqADCgwcYP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds3EDTffAzMh8JEz+W8FxnAH9vvZstp6bSSlX0uMyow=;
 b=fr+OdrNEFmmqgg185ZqeeB6JLppErDk56/DV3yQV/rZbAncxITnASnzpfoHeX6YsgNQYNXLqUbhHM2T82xF1qiv+MDtj7TKn10KA7/FhzxH+FGpD5NSooo4ZnK40tibYgkd7Y2Ga8zC6BuQnFObIOeDG7n4PlCE2O3vgFoX0Bwbr/ggup7xwth8k6mFSMDJcOsvJ4R8UJ4QjVcul4JeEMyCZTE7ca6MJIhL5/1I+1yEGhjrtUjvd+3ftGw/Ox6cM4naNgTG+noKqxFkC9aCl3JALoK1Rx2v4F4zOKvZQVATFKrN/es3D9oce/Z6gRG86vFY7VtsojxF9LZZLpbKBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds3EDTffAzMh8JEz+W8FxnAH9vvZstp6bSSlX0uMyow=;
 b=kHLJ04u4jUM2oqUOfaFelf9E7VncH5febt4rc2OsJyZakIz1AcdOdV5ZUBfqNCfpeAVIzIeaXD0+9cBW5qC9zMpKlw3hcLJsjYymRQ6wQ9vHEJlv5LakMAs51NocdVmExNks06g45rtTyQMrkJntJ97Tv380PdIWn9Qh8qOKISo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7688.namprd10.prod.outlook.com (2603:10b6:303:246::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:20:11 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:20:11 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com, jlee@suse.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v6 3/6] KEYS: X.509: Parse Basic Constraints for CA
Date:   Wed, 22 Mar 2023 12:16:31 -0400
Message-Id: <20230322161634.2233838-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230322161634.2233838-1-eric.snowberg@oracle.com>
References: <20230322161634.2233838-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee00003-b97e-4abb-7d55-08db2af14f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VHcNHpcSvrxmyXvZX8g6eh/VaKA0dKl/J/o95il8t4282e89q/GQi7vp10rHXyZSwkrAYPpxUzmfXyoq2uyEkvoKV1SvVkQnqtyl7N8Q+cLZQJhxFq0TmBX2HWL0T5kNEvlrpbq189H8UvyzOk2Q+95JDVBBtDkmKy3DXfl1nBb+Vna6lfM9Epm9vG4gaeGTSDLILEyfwFGRdHvt0IZ3lr/A1oSkJNu7/xSqzk3INRqH6ZbnxijfFgvl9xOaSRdJXSJvBGeeL8FMYnQwm5McRr9Fo5aCeQs0bBBm1OswdCUJ3dJJWvzB/BHJ1FxD6tWgvl9UsEHwSt9tZ0PEnRBG2Olud6MGcqeZKHbIl/YhBF9Vcx+Bfv7YecY1BWjNOoDvzUsdn2UrpnGlXv/Z79X/6C7CbtLeoqW0jhMdEdwTqf9ATpvR/6ev2EG72CRzL57+uKzDNf6o8/EmNwxAyDAVzoTN17bKCmiYfRIb2mfpf8tWixUFD710UdeWyHv6Hw0Le1asbuzhHtiAYaPxlGMhCZubrpI+/M47BGCf03A1E3qoVUxjJCUlaMXPCFTT+/61/549EkuRzS0zjjm7O+BQLdT/DLzTlf358X1+rUJGYzppht4SUlnNFaoO44yBhWP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(38100700002)(186003)(41300700001)(316002)(66476007)(44832011)(8676002)(5660300002)(36756003)(66556008)(4326008)(8936002)(66946007)(2906002)(7416002)(478600001)(6666004)(86362001)(2616005)(6512007)(1076003)(6486002)(6506007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rlx8n+ZI39uAOwrqs6ulYvfqvsDykzafoAEnIZDEVe2GSVBT7DU7idLbHV94?=
 =?us-ascii?Q?+mNqC+FQLH4IeZ/Q7xX3bbIlly+uabHkIXRvvR6j84J/aUM6TgPVzegeqFEs?=
 =?us-ascii?Q?CCMAMXlEFPilbe3MpggaKCW5T25lUWabNkPplpCqNmhaC5sMNXvxkOXOnWUq?=
 =?us-ascii?Q?2y8X2BqC3AP0qwNxQn9G/S3oNyL2zk20AAJMpPWUBLn5kDQnUJNMFUMLiibI?=
 =?us-ascii?Q?+pmDNNoEHG3+DkVXF4/RfOBCEsfW0Ac/eh96I1hkKX+9hzYo3g2rU7duNmJE?=
 =?us-ascii?Q?/POdLZAELefKvh8HUJ2NaDq7TX35j7CwXmBlBcTKI60e7it4e4wzcb1vN0Px?=
 =?us-ascii?Q?XugjWAknCmjHg8UO3WdgcvPRBQrsZcX4T1Gj5NmGVcsFzLxKpg8nwRte1U9O?=
 =?us-ascii?Q?6QeNVU6z1GoFUL/mKkPsCYJdqhjxmy3xfH/clkuwsqlZ+GD96CDhKVrNYC7d?=
 =?us-ascii?Q?YgwNdy6xoX3fC4bCuv40IVcbV4jyzjFKkULHmVuEhiu3WTvFna4g4AXur25d?=
 =?us-ascii?Q?+m+AokhlCKAY0gkFUrtUDxkn4d0/+T1wVFMt7LMAshYZleNIPs0bZ4vMQual?=
 =?us-ascii?Q?cq3Z1+Jei3i+FWMkan/buGShCkOhezyyLG1HggesCGuxATIFCnZvy8h26tvZ?=
 =?us-ascii?Q?gbxu+dUGWFPWb+SefZgI0HB6ZERKwgqWIzXTnKyIxjev05MIHGxjePosoKgQ?=
 =?us-ascii?Q?Y97cz7tAf3/Xl7CgWknf2y0hITvm4dIWya4/eeZ3l11pBFfqiLxIFvIGPRAV?=
 =?us-ascii?Q?OuTn4wnD+OYigQtnk3mlaDqBFVm8Dp2jAz1jF0pWNGJGmEmBTNPrUh4HD5km?=
 =?us-ascii?Q?bEJwniqN2sLzEaBTQSj14EdBzSBhC3cpkh0evDYo2ai/wlHFUuBA6r4u6F44?=
 =?us-ascii?Q?a2u1G0bvRNma1Q45stbpzxTuyvfrf5/RfPZ5nL5PogVZiU7K8t+dW3zrK4Mz?=
 =?us-ascii?Q?e4c5ArHX1vu6iX1IoJGWP0/UY8PBRu5nLUM6JLKJHZhFu6gQ3Og/B7pizGEV?=
 =?us-ascii?Q?YwEqsYfxDXLlRVcltd2/yQN3ah0YUSGz+5GKRFRQOTeVexW9KUfMEt0w6ojv?=
 =?us-ascii?Q?GsWFJBTiWaS3mSURSVheTFs8oSKfHYYO7v3WkIypP8Qmh7oba5FqqwOgPRmz?=
 =?us-ascii?Q?rM+h+9TiiKtILu3n+Duvvl22XEjR00XY7/+6+s5XxiFUMX/r5zpeo39nWViG?=
 =?us-ascii?Q?h79ljffgZ2NKCtmZFFuQvfS/p7IupxryBeY+3Netfo05xLt/TMglooCyXLJJ?=
 =?us-ascii?Q?ylFQd8WAlRENOZ4iMGt/vLmgjIJ0R9XYoH+N2sv+2NIrkLRTxT03gwXS4vYt?=
 =?us-ascii?Q?8DuEZWFSnxGbOiMBwA7okQmqUprq4RHnZhLnqz+cPrqFoXZFCfJrcbRqMqdl?=
 =?us-ascii?Q?6ghvEvWBv+jX3kELUsngNPkf8ccuiSPV29j1LSjQhM40pl83ru8N+b+z3Yi7?=
 =?us-ascii?Q?3yK5MVUHblbkKR7oYpbCVGnCuPptj2hMJ/4iog5VEoO177OQhgBUotIPVwX0?=
 =?us-ascii?Q?glAtSEbyF58HgYeleLjWxjdbfu52GVgbg7Xwu80/XK40wVnviZ8Dz3sLGivV?=
 =?us-ascii?Q?Tdga5lK+1Y6EotzOIqF9msTZQfbCkD0tRlZGOfo5pAS0ZH/I0CRhnB81NaEY?=
 =?us-ascii?Q?1zGR2SypHib7x4+IkrdqXcU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tWX/TSuveJ42ayitbgg0L6mqrRYU0uW+GWsy2/2zD7kcl1ePzGPqSc1g2sml?=
 =?us-ascii?Q?WsCtyYdJebBABXRkOKMUaTSrhceSNUrYfE+7uVCfvwfgo/gTh1gvQEULZGGy?=
 =?us-ascii?Q?dkxM07UoQ8F6hS/MWe45gNwWBuF+FxACwczybWTcXyczA98PepbCEeXblA78?=
 =?us-ascii?Q?LC7twCPy8XSHNIxoK9tz6TEh5Th9Ty16z6sCnZqddQkIOKmKS2KPTyp/hJN+?=
 =?us-ascii?Q?sIMZSKlJzXPCNKdpbHDbE+/3WRbq84xqgWqbtT2A4/iTrO6Pi881Jf0nlkin?=
 =?us-ascii?Q?OhdRvtVyAZA9NCj7bj+cEkGWGnTqsApubi2GD236Gniw7QM6tISpw8GAD6+F?=
 =?us-ascii?Q?6ncq/sDDyvmEKiDR1ITTqh6apV2OrRoEWtIRoC1QGV055QEQNe6rTjQgaaJ0?=
 =?us-ascii?Q?yYNJX/MhhB9TXA1q2oamtWFh51wkUhNeDJGLQslpUUOI7mScpJi7FCJr2PNB?=
 =?us-ascii?Q?Oo3Xvj3DURprbgJN0z0KQ6cmGngxgUkdSVSUX/j2h1MJ15BzPP8trZg8zVlQ?=
 =?us-ascii?Q?z3LYaq7qIK5ou67oJkLTel/XWxAL2zdGGz4uxVxYCvVXQ92rRT9gqg968A3Y?=
 =?us-ascii?Q?d8qgPawJZFVKYK7BIoe4mwp7NmUHO0ugTLfzy7Nu4uEMM68jCKTIncQSwyNr?=
 =?us-ascii?Q?1nJPzqgAtPDM4zPg+WfAbJiG2JZ17zJG0cxM4b5fmCua30wnnsE8e7Yr/4XQ?=
 =?us-ascii?Q?6HO8iItpDnovEuvvXtZMp82CygOGehqkiVHSnwTiHw/UTFB/7y5CzBzioV08?=
 =?us-ascii?Q?9to8EAfutAi77GZWUUNHVK62rIr9sP4TOAK++Yoe+Z20w5Ge3acUOrSZFkCL?=
 =?us-ascii?Q?5QeFfpgoYkdDhORj5hxy65HmDoiH0iDiGsSjDBHeAh4aiG9W1dvQn1wlMjBc?=
 =?us-ascii?Q?PEM2gytQ4MAqegxkPTOn/LDqVwgtcxZUzJnyJJYhUFAjiuXvQc+fOBwXkUAg?=
 =?us-ascii?Q?a+Da+6VPpRcKFFRKrEOVKwsTN495FvW9ONrE+L8pZFZndZARvYKnIhn3wft7?=
 =?us-ascii?Q?M05ewHMkfQQKz6Fy72CQ2qvyNMjH3iivd0B0/dY8pjfqrGVRvY3mg+JWHAVR?=
 =?us-ascii?Q?CXr46iOpFTUOnPDNK2J2DTNO26a/31vLFTBjTOvukME8TOMSb3TcoY7MiXjA?=
 =?us-ascii?Q?u21GaCKTJeMqjustvX3SL2fw4llKV1TwMx8Y0KcO6OCFQ6oBGfcgVPQr8CvH?=
 =?us-ascii?Q?umAEYtFPBbV3lVWe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee00003-b97e-4abb-7d55-08db2af14f73
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:20:11.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEAwnsXRI+uBB8+aEpGZimRbvNScInAKg1/jvBHLa4XVcH1OfQ0H7lVlqakjm0cYU/yT5QVpmVoxZG+WCmOoSDbAjuijA0jX9KI3zMoK23s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220115
X-Proofpoint-GUID: xAQqvegQ0KrgP5rjvDp3g7MYdwrkzDVu
X-Proofpoint-ORIG-GUID: xAQqvegQ0KrgP5rjvDp3g7MYdwrkzDVu
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
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

