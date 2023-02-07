Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EEB68CCE9
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 04:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBGDAf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 22:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBGDAe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 22:00:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B788035274;
        Mon,  6 Feb 2023 19:00:32 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDwXA000337;
        Tue, 7 Feb 2023 03:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=wIu+q9h8z/Kogj1ozDaVRFus2hpb64zL4tMk1ASDduI=;
 b=rqp8Egf65d75X8eNjPbLKQ/RgQ2/d0ko/EZRxqT5AuPB1AZTt5MJSivSW5IK74hNS16g
 fn4d7Pav+WcStKN5ea0MkhY16UV1C25Gvsz39TxaHeXJYLGzqGYtwZgNQhDxx52QR1gC
 B5pfrGyaERSKBPbIUi0+9MhQHshSPPYsQSClWYhmxo/jnVl7svW9gVN1EdGNtlianAQ9
 N3a2i5b1V5xi1SW4hXlRQSDceq6qtRtRebHUIhk2KWndR7TGR5tmmeUpI2dxy2RnAsjk
 33b5xoAcpxEKKGVJELe5Cxxr9m0nxvlk9xzwal8ma/WsCTXktLWM6ukQTJjgq3I7+Z/Y uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53cgbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3171j1pp016849;
        Tue, 7 Feb 2023 03:00:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrb9gdwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1kzupdTCuLlGJVts4NimD2JudFDJkZE6Tw9o+BmsgolleNYu/cJnjPDRNsrW81LwMlLRgmpgVblUYqvjCo9Go5dzEHvB1yneGdAtw6z21VtEknER6xQnaTrL4VlNVD5N2KxMTYKx4OmrnLBKpyJyhg9fWxIMA9AbTKCSTUDZJugpdJYdAXkujLjIfdK21U8WcQaRWEQNibXYTHySBrf2cyAAVyepmqflaUMWdhXJvGh6CpcYbZYXFmGtB6aopV3Or1Sc4ryh29XQZ+dlWDuuOM1SjD+pCbq/fxCcR6wBvGUzsQAwgdnBaFMSh4Bh9jJr01CGCTHKY2DGlFvgCOhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIu+q9h8z/Kogj1ozDaVRFus2hpb64zL4tMk1ASDduI=;
 b=iG6ec/9LQu2nnyLAMjoAaiWvYmc9IZbmEnW7wHvL+mur/avCwqwe3ZljzY5mb0snkfkKD0+N4MqjL2lIhji6xunO/VQOz3BKTnzXMp8UGDqVd6A0Rj0l8S9s1PE3BggKdDJRNtJj1/N/1Fj1OTfKCWwEvNjs/oe99TV/v2bz4FgbSFxoj7gSLQQSbOL1l/tO/sLmkYWPf1gaidmPibjEA7auq9ROpX3dgKLPGTUQxgk7qKwMwKouHU/90bnucbTrz5V6T1B/ut74VVSbvLhG8jDAVuyEMhlE9tVFg1F8e3kMhrGt3mSm+2pXmCDZNLqpofW078rvCmzLNjNrUv79JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIu+q9h8z/Kogj1ozDaVRFus2hpb64zL4tMk1ASDduI=;
 b=xN0PsTY6iCbk2oG0RPG0LJ/VjsruhFQoiXKFTXKQWNCLYA1cIxO7U9ptwAWd+8PhFVPQEJdPMUfFVO/KqRzKd2SyhKgfinXoaii8hkVlPrk2bXbK3tMg3CS2HVGopvK3x32JAxCkQvU85cAphVKmucyFPIgVC8Ky7vnepOeZcqE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Tue, 7 Feb
 2023 03:00:06 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554%9]) with mapi id 15.20.6086.011; Tue, 7 Feb 2023
 03:00:06 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 5/6] KEYS: CA link restriction
Date:   Mon,  6 Feb 2023 21:59:57 -0500
Message-Id: <20230207025958.974056-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230207025958.974056-1-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:5:337::15) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 332d71cf-823a-4383-54cd-08db08b76a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMfTydL3WIbwoSxBCbcHHQwhy57VqHAK9qcdNpP75cTbghO53XyVFcKqZLk2j/mxNazJ2tYWhorQsD3q6MSKX8BNOR0viEz9W0zR4Afk2NU2yz8XwvVBsMNjhVvsA2e5GC6h2N6waCjAqgdPdLbIbEw2gjYRnWcILiaRwRJ1k0SrYiudRBkGfVuuaG+zUzlg3HMlo/cKwmSzXee6Op9XOlFaJ1qKDYwYAk2Txp9N3NiLEAj7sD71tmyY4iRHEvwmr4PliQJW9/CUedMj1Oz7lrttT7OfTBmSenzjcNDlUl6/oXM06dT8PH4VVUCgNdDSB8UGyDfrYMy3+3Qj4kDComTqS1pYCwYY3/T+BRZ5/ic9ZM0gjqPWHfkCF9EH3pMaHzCOH5Oo1el8ap8SQDyGTlZoUagg/nUDDWaJNgmGRI0JxMtttO+algM9GO1Lf5CKPScgbJId6voPsVI8d0CMY/2vwHgkZ1zlkssE/uDMQu/QwwPuhcqqVE6OnMcaDqjnZTYV5+b2DVOPwgn1hjfT9G+eJ0WAUa+NlwvQRFYiBLF93Xp0jMVLb8ba7DI+OxQ+F3OqikIpaQLdehgXdEUqWoXiOnuPdUwplu2/tr3LAlNuPhdIdegly3hSgGgt1WWUuFekabRgYTPbkIGgsUh0aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(66476007)(7416002)(6506007)(36756003)(38100700002)(316002)(186003)(6512007)(6666004)(6486002)(478600001)(44832011)(86362001)(1076003)(8936002)(5660300002)(4326008)(66946007)(2616005)(66556008)(41300700001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ChwuYrUuVKMkkPxPApFwmJBudqrXZ4oQ3FUQ0eXGXgTzKON56G6LqPDONC21?=
 =?us-ascii?Q?Oi67nYJgHmYrJzZerDaLGNNSM5olvb0dWM+GCjRqVfoaiYayMx4/8Dt5lsED?=
 =?us-ascii?Q?Z3pu9OA9l93t898xT4cja3gvqbS5osDT2bZ8UwDASUKIwKJa6QYO2vysnJ3N?=
 =?us-ascii?Q?kbNvddVriWz4L7dcUcHjawV1Ur0VpQ86OuJzGg5T+VYka7gWiDCxjhtC4ggw?=
 =?us-ascii?Q?Qc+GF6qD3kULgSiQXyATQdnUxOCGCWN3PMWcf0Ra4Bcgoy6IubyCZf1JejzT?=
 =?us-ascii?Q?eV1/cWA8GreISQm/Y1up8DpI2v370/Ec8U/pUPorkpfu7JjIFsiIZnFZLuzV?=
 =?us-ascii?Q?cr1QbFm1Qrj8MuaSC7QOrALFw7t8QgM6+poFazgXgiEgW7jzm4MUV1lFSXlu?=
 =?us-ascii?Q?XK084RT//erFHuCriVHc6T93dWJVRwwcHcQH0BNm2cQzve4nG+KBVhwv4aa3?=
 =?us-ascii?Q?j8r4GFLgdnt19weuQ+ITZIPqOdMlrjjCZ+kqaBHPm3poCcdwLvCWSqwQDvG9?=
 =?us-ascii?Q?RO/RZ7RXywYD1BbV5NXEa8hx8DF5NzaWjAvGunIRMjRdHibZwylwqHSHrgvF?=
 =?us-ascii?Q?08IGeMpU62lYPrr1kNToxPg+LCWHnll/cIBwcXCWtX42EMNVDmJnQ3CJUAey?=
 =?us-ascii?Q?tGdEIb21yK7AlLkrmaoXZP/podEkUaktxlWWYdIBnb0RxasaK43Syr5ZzRoP?=
 =?us-ascii?Q?uF1yv42HchQtvsIAgZGc2359j1bx7yjns+aLck3qyymtMzndwdBdS2rAzSGI?=
 =?us-ascii?Q?VAuIeEbehvMtVjs/uyGWVBi9ySUVIFl+IfIXZ/QPb9awN2HzW5VO5PefYlu7?=
 =?us-ascii?Q?0AA6Mt2n2MB58YhbGqwRxr/GpJWZnQQtqDM+PtErNfzKZ4f4vqTe5xhr2z6R?=
 =?us-ascii?Q?5YaWBRh0q6sZr145TFkemxa9cny+OY6VL4ojQudS/6cf0LXKh7kdvHrB1/Ah?=
 =?us-ascii?Q?44jyfhA+bKCaRTeOsmqsBzMOpxyyOngT+qSg183saUCyudwc16Yn0xWst3VK?=
 =?us-ascii?Q?/3Mk1p6eXTSROd0fatXB8JM93cmHQ369HRidtSaR6AoYR+acze6Be9v5n5+r?=
 =?us-ascii?Q?bAgiYTw0Y/DSDwZWLln+6AFyVb/gnw8BjL4cGW8LPWF4q5/Rg7YeNp/KhcnF?=
 =?us-ascii?Q?6e0fDzVl2P7J2DHB6MpI9/aZ67nWa8XBvV5mBfsm1iZPnLXomSvcjZw79QAA?=
 =?us-ascii?Q?e2ILseGNAdHT0OumJCBDNtYMRaI3fAvEI0xJVg7+WlM6EDMdvn5Umpp/aeLO?=
 =?us-ascii?Q?3js/+JlNTE/gu2Xg0OycROGsXOEgsHYy1ZOSeGu3NdmeMWtbhEL4rzxZGJQ8?=
 =?us-ascii?Q?0ZuIDM6ALbZbqUwk+BnJqDiledBPxVrnux1wNegMj08Pa1j+GgjBJ9xS+tpX?=
 =?us-ascii?Q?LGV49qcQ86o3l+6OlKOCwYmPdS/Ux1+HLzY50yqKZyx8vufgNOhiGxvFYIGa?=
 =?us-ascii?Q?yNeiFAbJgGUFblI2SytStjj/EKc43nDJhus9o6390vC1ycapGxjVaBtlPYZB?=
 =?us-ascii?Q?3cLddL0vMCHQLSTFCBQzVDbK2EBqEmlNzP0Sha12rjgQwELdIHk6hMi35XSa?=
 =?us-ascii?Q?wHvSykbtCq/9K+cNi1k2eq+9eqXCF+hKpgtNFPzEC0RVFuZfHtO3Sa5anNL0?=
 =?us-ascii?Q?fcjg1IJ7xlqOoXn9qOQD4Tg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MxTOBZXqKesH/VB7kkdbhkjJUaSiNmdOSqy9jH/YvLFdkrdg7ZWslQSeMSpJ?=
 =?us-ascii?Q?JM9U1RZ9Jl1j6hHAmJ9UY4jZzzwZXCOS1E3SslQzgeNOFOq6O3L3Ow80HyNO?=
 =?us-ascii?Q?/sd8fDhDTJef34OT4SXrY8UiOuwYP8Kx8RuTf7rp9N5FmE3eh+ZnqgsbTukE?=
 =?us-ascii?Q?bgxPO8PpRaRtrtYcvnPOEXgCJFGRthnmk2S8m4Bp62dhmLKlr5byB8dfsQ+2?=
 =?us-ascii?Q?mQjfobFLCzGMCNXN2pgV+skS8oZZZnxS6H5QTIc6MbMmHOWSBaSUdEtuazZK?=
 =?us-ascii?Q?CY8752v3LndJNbdjOyrFkxnyr2scdhhPJZK1gN4QTxNpQbY+jpfx6fxeqSKL?=
 =?us-ascii?Q?xnFG113uimN1wkFFOcT9q7FsjhvBIR+cFb1h8wlrjBzBnIaXCLN0FIYyGQlX?=
 =?us-ascii?Q?9UE8bG7KPm+yCe+VqJVdlIMI0RFNt0vHdIvBjcPuEqIAZerVtVwdMyp57wVy?=
 =?us-ascii?Q?wi6vCGlbldhBt7ubtPpFmRfEkYbTNalUGscsrLwK0G4XdtgYcs1QtchwYtYP?=
 =?us-ascii?Q?ZfNZ0VFYqbY7y1fp3y2W1fbZ2Pr6zxmaD98EWDbYzze60R9LX75Z6ZQiMclB?=
 =?us-ascii?Q?9sRUt0anyYqCQoPZCpfV+vwmUHrZaZkMM/z/XZLX1zm3Vy9zmRTsEuvENfol?=
 =?us-ascii?Q?OU3o5cgPcrre0aSEu9LP9UcB7wwIdlh6skGxLCPSygWvZO1DH8pa2+zq9oee?=
 =?us-ascii?Q?FRKNXphzf9PPUd97mz6n5ckLBb0qgeg27TgwZvoOE5IFp2V76EKBoaDqmqdM?=
 =?us-ascii?Q?dfWvNEm/1qDqdfLqGzyLI7KnCWmYyxwDbEuLBLMkM5F/0CegRgVMDnoGKXtH?=
 =?us-ascii?Q?w5jBsD3DPVAFxlwn9YCRdCKcmJIYuGsfpK7PHWuXQnyQnhQ8CYbMKHZBUXOR?=
 =?us-ascii?Q?oD6ka34voiCZi6l8jWREr2wCsh1koO39np21Xu+F823D3TTZBQWb+/CC8gX+?=
 =?us-ascii?Q?s4azwHXP/7wx4sn8zFTpG4hQkl21scZVR0DTGSxsUAPa2K7aUBxhXGWAVf66?=
 =?us-ascii?Q?B3mQZpAR+YLNq2SVWFb0cvIh8Whpj98AhUCm+FdFGC6FbpcacXhbM5RlNQAX?=
 =?us-ascii?Q?JqiK1p0+8PzaW98zGQzCwMVDPm9vd/CmcJ2CsCfmoyRYZjcRTEFSD/wzmell?=
 =?us-ascii?Q?c54RrXFnNYyqtRVtCqN1nb6QDcwWChMzPOKB/jBlZlUj2r+XJk2FzsbJNmjT?=
 =?us-ascii?Q?PJ/y1mk7yE9s9AOh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332d71cf-823a-4383-54cd-08db08b76a36
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 03:00:05.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PB1naSyTqHhRfoJnv2+mAAFdSnfLa+qds1gjCTWcxA0QWGOALk2qelddJ+q7OejURO51ZxFdfhvLQiTMO3vqtUQnjx2vpLoWe28gF2JF4hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070025
X-Proofpoint-ORIG-GUID: IHHapfLFoQRipky72kSkBb5dVjXRQpAl
X-Proofpoint-GUID: IHHapfLFoQRipky72kSkBb5dVjXRQpAl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a new link restriction.  Restrict the addition of keys in a keyring
based on the key to be added being a CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/restrict.c | 38 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       | 15 ++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 6b1ac5f5896a..48457c6f33f9 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,44 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+/**
+ * restrict_link_by_ca - Restrict additions to a ring of CA keys
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trust_keyring: Unused.
+ *
+ * Check if the new certificate is a CA. If it is a CA, then mark the new
+ * certificate as being ok to link.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if the
+ * certificate is not a CA. -ENOPKG if the signature uses unsupported
+ * crypto, or some other error if there is a matching certificate but
+ * the signature check cannot be performed.
+ */
+int restrict_link_by_ca(struct key *dest_keyring,
+			const struct key_type *type,
+			const union key_payload *payload,
+			struct key *trust_keyring)
+{
+	const struct public_key *pkey;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	pkey = payload->data[asym_crypto];
+	if (!pkey)
+		return -ENOPKG;
+	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
+		return -ENOKEY;
+	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
+		return -ENOKEY;
+	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
+		return -ENOKEY;
+
+	return 0;
+}
+
 static bool match_either_id(const struct asymmetric_key_id **pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 03c3fb990d59..653992a6e941 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -75,6 +75,21 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_KEY_TYPE)
+extern int restrict_link_by_ca(struct key *dest_keyring,
+			       const struct key_type *type,
+			       const union key_payload *payload,
+			       struct key *trust_keyring);
+#else
+static inline int restrict_link_by_ca(struct key *dest_keyring,
+				      const struct key_type *type,
+				      const union key_payload *payload,
+				      struct key *trust_keyring)
+{
+	return 0;
+}
+#endif
+
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
 				struct kernel_pkey_query *);
 
-- 
2.27.0

