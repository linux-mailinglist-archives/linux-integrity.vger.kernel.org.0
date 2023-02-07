Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6AB68CCEC
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 04:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBGDAh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 22:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBGDAf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 22:00:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B593527D;
        Mon,  6 Feb 2023 19:00:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KE5fY029679;
        Tue, 7 Feb 2023 03:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0y0v3HYqXP8jxWz7DNC1natKc715TPpcOTI2z4B/XtY=;
 b=WOYHaxbehtjloTMw3TE3ZEjX0YHMCq7mc1U1MYLJK4TVlKPYMK+AqdNWUsGLPW+aPkfw
 WBQaW3g0PJld+gCcE0YApINeIyMtDYfDUMVn08QvmPhaWEyap/1p7VABgMJ4Rb1rHgLI
 wl32geLy7aZ0qhaplyerV5HLBMqiuXZV7j4Dfay4oRD5uCI4ArLDzrqhMfQg92vngYWC
 jxWq3Xbbd3Lm6M6I4aRLgBRMRxYZfmQxApimPzaJvrc9QG1XAgfij8V3A9KeO0DuPURX
 Ozv5tJcc6L5KCQOt4ccauNZTpeouyR4eOy57xGLBwPW4j5O5zY0O/pfiu1nih1WpWpzo bA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdmh3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3172s0fV020885;
        Tue, 7 Feb 2023 02:59:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt4yqfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 02:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly1LiiCQGyLJZIQb93lOJdJcE4tEKoS+vAsu6NVnarTpSJKjq7P8PIUxC5ztqcUiKmy2qnyi7bZHvtoTC40n37V9bk6HO9ihBymx9dkIYmDClRoCVTx4wDSIyJf+NJ+rcrkqs7NBq57mIwQhMRVGmuGfCi4N6BNw0Qpk7PRiJ8/0dnsmqjOqt8PL5fQ0p2Xd0yWD4DFHACQXwaZezQd//zQ+L01419TV/ETBsnwbmUGf2krkqve8kfTBpC462Z6BxiP5na1CRkWbjN4DMiAZYof0zVuZIZE5GfdTD7HfVD3HFaKQPBV1kQaQO+ejyBoMFAq1Sk73xns69WRxTSBfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y0v3HYqXP8jxWz7DNC1natKc715TPpcOTI2z4B/XtY=;
 b=FVq1bdASLyRIgu/ocro6cNWLf1oNLTr9Y0Tnz8Qla6q7gT9ZGQcsMQmMNTBxsyQ87qtW+aW7JnuycFOhLeL4NJpMiX4lv975hMKJ4VBhMMNVQinNDYQsbU3muW93KQaJGYnlJ2w03iGGG2i3DWVFTvBrty3EyjEGWn8DJfG2557qPTFwm6nfT+rYA/Pswi58aml5nwnjavxvOK60LwYSWREpobBItHih/EzgCcvmUZdHU/sO+q/0WXm9+HMYcvVfFO+ZIjSUI2GlbdAkSmkERc/VbcoBfWABVE5C6LqnURK8y/TWQJAfWWb9cwOyhxBuX8sHTGD0GmuaHCwrXIp+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y0v3HYqXP8jxWz7DNC1natKc715TPpcOTI2z4B/XtY=;
 b=OMUvzHmGq68VHJcQ0eVHOhz2RUoRK27gCo7s0/U4dQ63A6SEZaKKz7vhrBzytIkkkRvUCt1BSJn6raIgSCFn5AMNYbaMrkEjYJjfIELNKvx0T7XOPj9ZCKJy7gN0Y29SbjMGtilRI9Y/fEWojaftQGpe+DLS/87evEy1hWwN56I=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Tue, 7 Feb
 2023 02:59:57 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554%9]) with mapi id 15.20.6086.011; Tue, 7 Feb 2023
 02:59:57 +0000
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
Subject: [PATCH v4 1/6] KEYS: Create static version of public_key_verify_signature
Date:   Mon,  6 Feb 2023 21:59:53 -0500
Message-Id: <20230207025958.974056-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230207025958.974056-1-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0106.namprd05.prod.outlook.com
 (2603:10b6:803:42::23) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 853bf529-2564-48f3-20e7-08db08b7651e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sRGjkFbS4z7jFrsuqM+aQsSJsFhwZbkE5b3vVmwfjGPbvUyHhpYO91K9nmal/xmSCq8n2ZL/lDqz914SdMvKTBEu/VLXhTA428mwAgZKdooDXwNG0GP8o3eTkTkofxtntSiGdS7cEkD10K0mbdwQeL3nnKYGMQpUUwTudb5OFgkWOPRrEyn9G++cV4fNHSb2aKW/kjcbtO2BmL1R5E95hYNhYJwvAR4WiMGtzGHERCRB1D94bmSU3cC2GKAUlC/AMNFZUfqiNofVmK4NH3ENQIUDGgIicSbuh2SDpq/R19e4WICcdbnCt8X7ShnOQDRE14Q3KeFgP7dijpDgQ/QS2J+6D5p+PnxOLLRJKNhAp4YfCaGBzn2DooQHKw3Lu2OE1E8F7Bp2xKP7wervjHXvs3ar50uB4zUwQBPpqcq7g5CYSe+nnYvHmaMd0K/x79sVPQZwN4/itn74gfnFoOW/IIZQLZ687CbbUjSo2OyR/1/O+kSlr+M4ZHMk1Okw6JEjhW82/HyUwBSRe/CRZE3AtExK9VYM2vLoZBFzs3FBF2g0uabgbhTc+PjgAxS4gW44z3jJ44p9MEU5RN634610rhtwKdwYAoNChSk0kLrA25BJyQhl8K54Z/xqpR1bB1hZWAxXjrhUUx78IeFaGyiYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(66476007)(7416002)(6506007)(36756003)(38100700002)(316002)(186003)(6512007)(6666004)(6486002)(478600001)(44832011)(86362001)(1076003)(8936002)(5660300002)(4326008)(83380400001)(66946007)(2616005)(66556008)(41300700001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2sS36o6Ng7FeAOSogf7TSRV21RASDdi2ebF87/m6vtKosO4MRIOLTi1z2dX?=
 =?us-ascii?Q?AohqbPoAOuqoMwu/vAA2IGo7imZ59yskQ6godpHmniYo0yj9a40+eWnvg6Cv?=
 =?us-ascii?Q?OLvXLf/0cV90COI8w6+D7wup8AItmIpZ0MT/n6R3fx1kzlbjlbR56HRHXs2Y?=
 =?us-ascii?Q?xVugBCRuPL6HwUZjs+ldAjQhj2wMyFvWMJe/avsWQ8ywjA4XweENQYSGoU2o?=
 =?us-ascii?Q?CBtW9cD7oaxzT+F6FITDNf8vFEJR1N1ZADqVRB3LpqeIZqf0ADMtkLcfHjCx?=
 =?us-ascii?Q?qFlPtcHw/Q2Lcn2WcNZNUQvNrMH3sZZ7Z3u919Ao10hYThOdIIBt4cbpX3VL?=
 =?us-ascii?Q?mwTVC40D6p3DI7065nTkgLA/tWAXUrS9kjJW1ytfYytQA4k1M2H/7vEEqci2?=
 =?us-ascii?Q?msjr09EZEW8kxnVIG4+nhLq/WtgGOWZDmeUZLkc1dphQD/NT5cfiK2U9T0Ir?=
 =?us-ascii?Q?qh4NY5hyDHFRke7FbFnWDQ53SdMdNqpZYKeu/sXmmJ8imqJE28meyyOLqXvC?=
 =?us-ascii?Q?oGaoF5eVde9SM2AzcHaMSU8k0/i2x0n6L5zhd8MSknZF18r5N3rDhLdJL/xW?=
 =?us-ascii?Q?ySUnfpYTLNsdWrKr4P7Mh8hAHNrAasFhBXJLXH8yWvfWpv4d6S6zzS9dKvgn?=
 =?us-ascii?Q?zYxE45bYDVkciPq4kVbkV7oz2SXzc8dtTUsCIAb0Zgh60daHlJq+q8Fz2GUW?=
 =?us-ascii?Q?RfnDlrADeZXGNGiYr5sjldoGNL0nzjEKjvBhRqn+NYv0LA8dkuPMlhLgE5cC?=
 =?us-ascii?Q?gk54cQ6yFF2K9HPtvOjQpkj5I7oj1ZZR9/mzcoFfK7wNXtPEQnSdm4aV45lf?=
 =?us-ascii?Q?mpfe5Ibp/mt9W8YBNULHaBOhK8GDecFknKAdsLrHTd5pn4rr3Jy37rIN2BWN?=
 =?us-ascii?Q?7EQ3f6aFDR1Ml6NNA9h00IYaBE1KR7QALi7IGhzj1a4NsjtPPOunz/hxy5Xh?=
 =?us-ascii?Q?yI9nid4/drUC0lpe8HrXDuD2ZWhJS/jWrCN2Rt4Cvjla8hevayKMMAxog7M5?=
 =?us-ascii?Q?jBk75klGM+pzNlRvhCSfZ45d1Ep+vTCGKRAd/2UeYb1I7AYi85jjpLyTPN2l?=
 =?us-ascii?Q?UkGfvdS5/WywaMwexbwnJzyXxtziNyDQF09eKM3f70uiEOUDW7JuVVif8LMQ?=
 =?us-ascii?Q?OqqHE9k/Q8INGIUZyO6VO46Nk2XlhVnQIvwmgVxB2QwvrHgj3cFhkofD3LR1?=
 =?us-ascii?Q?w6W8Y+OuBUDVM+uKOLe+PVIcXty3enfYzF78+2pev4eTBzEbZTVQMsHBPM1C?=
 =?us-ascii?Q?ESieA1PRvRCcV02zX58DZ0iTFZih8qziOROYHcgJCQdOI1UeeUYe8iVsjFM1?=
 =?us-ascii?Q?AjLD5J16DI0evMJWLWqsvZTvyIaOo6EFCcXma4hBqLtzwrft48wsiT0+osZd?=
 =?us-ascii?Q?gI6rk/WyF1guRZPCqVJdY5Sr7lzmGF6tBHO1a8UzV1vUG/ZBt5u8jt5OQf+9?=
 =?us-ascii?Q?Nm3pdUfRnKS2qh4ax9eWB37SJ7DACfblVmMZMGI1fXngskQ6PHI2FkP8YpRe?=
 =?us-ascii?Q?wmcUJO264uYNMsY/kJe7P9Vb/jMVjAL1jUTcbgGN7c2oLZG0OE4jiHHUKBd+?=
 =?us-ascii?Q?3OxGoeYH529lyilLqvserZsWVB8I9sGO66i4EAkR6YfAoHnxe+JDlgIslPtJ?=
 =?us-ascii?Q?4w5WdZLPA3gEN3ECXM1DebU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WBqPBZS04e66X53Mdh4e86Ym8g+ZFgXJkw0QXpBTzDYjW2Dtu9YcE6y/IiSn?=
 =?us-ascii?Q?PvWldnuBXZuS9wxkrQZGErY3eUyrnsahci76DyboZbFYgqaq10DhSVHbchhq?=
 =?us-ascii?Q?mPqauFFxrONR805119gKkuaGFFL7fOPaRpWW6B2ZL8xCnv8LrptGk6NwexUQ?=
 =?us-ascii?Q?uqFvZqjlBdL1ma0CXLJKs+3wz57ep66IWYbvm8CUGRU9nvIirb2sqO9eoEaB?=
 =?us-ascii?Q?6TOvw38haqniIjmAYssdt+O8ByfZ8tQVZ1SKWXw4lb1oy5O1Cqcrrj4JiKWD?=
 =?us-ascii?Q?3koXlWFqUotv4/ak/rk68sm139nbPerkAP4AcIZXjTza7v/Z36SJv+Dt2hcY?=
 =?us-ascii?Q?LmPJdGOKFdOHpSRgPobeF7MiP21UOkLivVh1e0oLk78cmTj4Y8tOIt/l/02H?=
 =?us-ascii?Q?WXexmv5z8Zy3NV/MRnCXrioGu9LcThpgh5HUGID6Fx2xkDv739g60FLF4h3D?=
 =?us-ascii?Q?1EoSR2FFR8bdbbZD6IvlyZAyvb0/lgQBhEYJvE+wp8W/NfxQorFg5LeLbCGZ?=
 =?us-ascii?Q?o1KBc+EDxC3FgWHOYsix2enSMFPnxxjdoborwKL3MFbaSsz6rLeJhmgE3kgh?=
 =?us-ascii?Q?9tFlcDA7h0PAtJWT/UFlrg6Kvx/6GiGGVUJk0/AtVHwmbN6bqnGkPMcH/vyD?=
 =?us-ascii?Q?PaI7PTU9jImOgJ+4J50uwRwsBH/58tRFJvZNhyplQ7vTzTXI/pgsvtq9oZjQ?=
 =?us-ascii?Q?ddxugtf3rDZKXGoJVOCtlDLMlCxZKUwTsqor6T/rZcjpQ4oBwMb69ikDsbRx?=
 =?us-ascii?Q?NQ/w0u3Sf5GUElLyUWoC9iKLky9hETu7uHcYDpnnFuXEzQbNiOP2tw5ofTJy?=
 =?us-ascii?Q?s/n/gN8qN/QSlOR3jq/n0xZcr6FcXbO4f2YrLFVfsmU/uF2CS/XHfDqhgYZu?=
 =?us-ascii?Q?C3YusirbyXMSmN1YW9CcXwRBjkgO71fP7dCb9i1hFeO8arfYU7cOouUOwH6p?=
 =?us-ascii?Q?0D1EOpkChrGlE8Yj3BQEm/xkwrEhn2Dz9Mx0+H31AKtzkUvZTCFhgXfFpZqj?=
 =?us-ascii?Q?qa7QJolvwvSAMMk9WMSw65GGSnQo4mf0QAG/rzCO75XSV8oz+s2+LM5wRkki?=
 =?us-ascii?Q?Tpto6H29zwN+WfCp06Lf/qX6XHawO+bgx1gFUGzcf5nQ0v/9K/ZXe2e2x11v?=
 =?us-ascii?Q?ir2tfI9/VWZ5WATx0khSs/08i17TMxEQgxbL0mhk+2vGdUysReP/dJyfM16V?=
 =?us-ascii?Q?kkxETsf2aUOYYjMo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853bf529-2564-48f3-20e7-08db08b7651e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 02:59:57.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULYbbP1SVjn+Q53VIDOd+njn0O+G00GDFUP9BM9PdZpiDwZLs9UxT3qYnpR9a1bawLJd9iBEC8L34NJrD8PWXTShGiktsem/tpBnPsaI0ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070025
X-Proofpoint-ORIG-GUID: FwzrPyilwQvoN49w5FyeHdrZuayfPct1
X-Proofpoint-GUID: FwzrPyilwQvoN49w5FyeHdrZuayfPct1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel test robot reports undefined reference to
public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
not defined. Create a static version in this case and return -EINVAL.

Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to the akcipher api")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/crypto/public_key.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 68f7aa2a7e55..6d61695e1cde 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
 extern int verify_signature(const struct key *,
 			    const struct public_key_signature *);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
+#else
+static inline
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif /* _LINUX_PUBLIC_KEY_H */
-- 
2.27.0

