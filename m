Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64BD68CD04
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 04:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBGDAo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 22:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBGDAi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 22:00:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CFF35274;
        Mon,  6 Feb 2023 19:00:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDw60024677;
        Tue, 7 Feb 2023 02:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=x3yfkIF61NtJvUeIXWIEiM9DfOna4/Sh6rkeHIWAD6U=;
 b=I+/+de6cUJPDZxSqWjq9csMIiWonHhb01cFT8p1SVF2DKLiodSPJJycq7t0eEG383N2v
 6FEESBI2iCaa5xuCwcmLfwRa683eRrPHhtWJ10gxyTKr3aZGs3aNHYsVsre/GF2PklLo
 BhsTX3CGI14W4AJFSN1h8sDN8MlBrF7NWdxYMt97G55iySkj9Vn6me/effDX7YY0W2/K
 syqkmlZaZhGESL0r6Xw0cVGHjxQUjWINUX7iyq0b4QYAYVGvlxe4Bp9FPIRUvJRVndu8
 5Zhq6cILXwPJ/xsPrxVxL3ZuTrFkER/7XKJyXuDGudIWS5VqWAnXoX66panYZD1uiBZT ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwu4ckq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 02:59:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3172svPo001622;
        Tue, 7 Feb 2023 02:59:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtbfngs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 02:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJiCLvTm7yNCfxSisVGSbkno18V+fwtWhW2MsFwFH5Ud87dKvBoJ1cCfa6JvAAKdToU10bkbo8l367mivo0fme96ylrKs/qJDxmVhfmR+4hvBsHqT9oLsmLM7dpUVlJqgjv3DT1flQmvyB0Ii73b9WY+SHCBuG4gXPiIycEzp23Ja9dReSbEIIMQzkIcZkwhwEJXPvgvXZ3INGvZi8w5cnVAjRJBZwdCxE3ONFNihIWJp/1OlJm6DQR6cR9M82u7PRqMz2q9LLfpAv07WQgLwz2U8DAaMI+AXaVpvoapva15RM+SGlVJ25A6nTxECPDWh55+LlMSUwmPbvJbVeACxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3yfkIF61NtJvUeIXWIEiM9DfOna4/Sh6rkeHIWAD6U=;
 b=Wt01SiJu2LAZmoXGCypI5/xvdIVn0zg/5X4patE5F5/xf++vyoSWXY8IIM3Ml8zz7K6Rv8FsBX3gU/yH2p60sExe2q2JsoMjv5iIg5F3MM+Yl+cuG/Ph0iVHWLzDDdCcuvrRHOt85zD0RZ4eeOJHJceKL6cJX+DedOE1DARKa6v2xj4C+GySdXVJEefIKPx/nwUZvq4i4hPsKjbydhfsFhNwbLl/yKk4mYxHVdr4Z7O0WYc4g92pU0ApNBGSS7GLkK86Yg3JpP3xJIb0moPzwj+VT21pRvagxqKAshuE62gHmlaws7O0OFmWpInU+zZzdFGoCb+AZU8Wq1d9U/k3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3yfkIF61NtJvUeIXWIEiM9DfOna4/Sh6rkeHIWAD6U=;
 b=TNNaSkju0Nx8ufKmw9Tw1oRaaAURuH/LA2VTtKQyBLJbgcBych4hnV3oDFX/gfj+Z3XEtpCGgHoSbs15q1vwJt9oWgftEvOHQncc2YEAnjN/6eJsoJvmT6ICZs47sN8DklCa1p+xn7b3YOilq7x0293QZxSmhyNvF/RHT5IjqUo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Tue, 7 Feb
 2023 02:59:55 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554%9]) with mapi id 15.20.6086.011; Tue, 7 Feb 2023
 02:59:54 +0000
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
Subject: [PATCH v4 0/6] Add CA enforcement keyring restrictions
Date:   Mon,  6 Feb 2023 21:59:52 -0500
Message-Id: <20230207025958.974056-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aaaa8c7-7db1-497f-c4ef-08db08b7639b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfKnG72vj4S3kkalR/km7ttTyp5TwPQnzsrlFUH1gq0NZGahQlO5Yf9/iqV8R3F4vdy8Gk2Y/5t2uV8q/mzcBVqtEGgZehFx0kCt/KgOMj6Ua5K3x3vAKtui2QZXvY/7/f+IPcIaGsFVfnR6KJuRePkm04pVWWzq/Gk+hXI8sm2MoRNcUGRN9tDo9HwOizPBx3YEr2as6IFNndCi57w48lmE+Vd3k0XG1JMRA4hIMCfer0hgPzI3n8a2/5lTw0GIlaRc6jGcy1f+LvphETEpwZTQN0nRykfisaq2xvVnW2o0wBN9ewpDCE+R25b1RnSC9yy0lEU8ID8jLj+L6JBtWIct1KdL8mdKgDHGipDTibgP/u00fnjPACv8cZ3s0E6GB7SXEgxoAoR8s617QmhTr5ZQ36b9QaXyPAlMX+N2lc3HyAD7wDSOyjas5wKwNaDODgdDQFK4oDEPo9hXaPBb2kNP1vsKcrBXvWJlRX+vwpUKXxqv20/+DhP0ftcb7Sn0ylfh652q5t8/yFeOxoZ37aGLQecFQkd/zFg2dQ/B2sFnk4J8RmoUSh8cwzUv6ZE38YkMnQJmJGcTpbMHOxVvJOeqWOQHruhyY34YO3sKSsPrEINBW7vkrm3G4+H550oar7uIYo4Q/cGP1ExqPv4jQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(66476007)(7416002)(6506007)(36756003)(38100700002)(316002)(186003)(6512007)(6486002)(478600001)(44832011)(86362001)(1076003)(8936002)(5660300002)(4326008)(83380400001)(66946007)(2616005)(66556008)(41300700001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KrvYmZSYr1E0evqOp8AJQeL1xR5yr5ilyP8LPi6rpSGALhv+bbynEunAAtCM?=
 =?us-ascii?Q?LR/aM9UrDjD1tjvb2y7DqqVAzxiGEtyRoidfeoagojzFjHRlZFSyZ5mCrUZ0?=
 =?us-ascii?Q?A+gu90VrYyfNIrwGSsEhCCW3hLG0Oo4qGQkdk6/j0uMGTOnE0X1a51zZftzr?=
 =?us-ascii?Q?MVmCyle9q1pj9xwGtQ3c9USMpuhiE5iOcd0xMGXTm+5rRDPna2W330/JTRqt?=
 =?us-ascii?Q?4ja7hGMFynoj8GZQedF6400mQsQwYZwnDFizjfIduUg3tKrwMlAuVmJMPWLp?=
 =?us-ascii?Q?77TnSiMjh/VZ2KpSerpfviYEOu7wUAn0eaKzJIo4zzecGeC5pK+9eCTKLRB6?=
 =?us-ascii?Q?ozL7Jhc3ys2+phsPUWjG5qUQF0CNBLUHhCClXwcdfHMMDhgkm1rh0yFrNSMD?=
 =?us-ascii?Q?Dm2DKRXj77Y0vomt2/Rgat5L+8o9aW1yoUsqiD809g4cb5BM4p4ORhqvQzUC?=
 =?us-ascii?Q?FoHZGMmHvTFhGa32gdBVHOgQ7LHxUhOU+mXWWGCtDrgnMmE+sz2cPaWS3vW8?=
 =?us-ascii?Q?/Cdf3NN52ePFbbd2FJXit6nMmTLKZ9lw41Qe53J0bL0hCLWJkB5ZqloC4f/8?=
 =?us-ascii?Q?+76cGU0QUP272Z/PhIzQ0rCcnsEr2OyYMcZbCoxAHFWavgpJQ8CHybef9ysm?=
 =?us-ascii?Q?IgdCstg4Yf1OSIVkPoSybSsq1D8YLhPzS0DgjlGQ+3g1ZqUKuusoIpfQV/kK?=
 =?us-ascii?Q?ViQyHGs9ZLSEUdkmzTe0pbvhx1RjfdN3BXw8ZaHVZUNdvSiS7gjGxXx+iYVN?=
 =?us-ascii?Q?ZV8FdUmUvEUIISQYCAeZdGeD0yhAjmH3HZPMfHumTyeWf+370k0UZovh1s8i?=
 =?us-ascii?Q?LjPciq86bocrQFP+hYZfffxd5ZRCCmmHvll3rUCtiDONh4G9zugdaUBUG0Jm?=
 =?us-ascii?Q?sVdCaVKbrxvrCwFYbKH5aATJUA0v7mA1yT7GcXpUlAqhl+sEjqw7AZ+36kyv?=
 =?us-ascii?Q?Fv4xP2aSGi6DYGNkp3GMzJ2MqF9nV5eyECTFTLLNHWohgrFm+GN9bQZvHXwy?=
 =?us-ascii?Q?C2Mvw+pzzxuH83jIOI/W/wya9aD7DRiqQIyIoV4xoaWnM6LnbDU+SZwk7o+E?=
 =?us-ascii?Q?Gb0pyfFJ9uK80I02kpOcITJ+soSsRzgMPUUtUcv9XzIclR1G/sKkQkwjngCO?=
 =?us-ascii?Q?+Qws7OwwlWlo0GFuiOQlxwfLidJewUrH03mOlb5E2pNpGF1z/hRUqD7IuEkD?=
 =?us-ascii?Q?NdLwFoJpSMzIdEjxSMsEUFc38YjAC3BqHnpl7nmB1xuPLfDkPmCRGuTFhkit?=
 =?us-ascii?Q?bcuhjR5nmulyJBb8KmDRQMi2IL1hGlk5cdp+uiuP5YGX0enlZbLig7nJ4wwa?=
 =?us-ascii?Q?yvIBqsOT1gvL/F2TgfaOR8IjSL9Vtnia1thUboNPWr5ec8ujsOsjSAeI+kqu?=
 =?us-ascii?Q?/inOhV6+8+uTGSpv5pdw/vEUSR6oTr22m9ZAGu2boxCskj2O8SMPEhIvb62b?=
 =?us-ascii?Q?xlwIsOcekb7f8bO96nbC94de6UPhSUrwbqBTN3Bx95g2J/9cGaYSZwvKZ68t?=
 =?us-ascii?Q?ilMQmdAy3aXt4+YqlTjMCuyrFVF9CV7PGgLihM+GVFXDyDipmS7kHeLJPaY3?=
 =?us-ascii?Q?puGVQ9m8Z6Nid8vFAIi3qIdt86P/C/XRz1KplShLOdAbRU7qI+P33sPxCCmb?=
 =?us-ascii?Q?edL6rituwCZdNAmlPR7XqfA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TjcRjz/3pbxckW8o2GL2N0rKBDwsvTHgNhjSJdlxvAqZniSFkRscSJ9plys6?=
 =?us-ascii?Q?cmTxiF3IhmA+hDarZeN7yq425fY81CJA6NZFodvnTsclDwWRv8x1JZxhJ/tA?=
 =?us-ascii?Q?GyMOEy2iTuQ/tR82ldjMD9se1z9Dx28Zbf4bGuyx84VFv39EOSZ7H39kye/P?=
 =?us-ascii?Q?ra4luguxFzLrqKHryzQqxlX4P3Hrc3IDQ53KfyzNnPpRtpdhIDqrX5Oe5xEC?=
 =?us-ascii?Q?rz+H9VEZrqLrRfQ1YDF50B5AsVRgAjnlDCK/9ME+z6D2ipWCkUMFHCYiyX1t?=
 =?us-ascii?Q?jfAu4jdjm0sYJNtt9IMNDHAKzu5fcw/83A7wEN3gv98yUFVl6xT1ZkdbiDdf?=
 =?us-ascii?Q?O7MOnihXAsyCjygpS65dvOOWB/fzlCFtxm5fAtLJ4B/JLfcumwsPXzTCBHmF?=
 =?us-ascii?Q?ZHAyY6YNHB5trmq6PQrboK9FznFm5vPZrEZrLtMmY1e72sZ2yDZJN5+Bc6zV?=
 =?us-ascii?Q?opOMDxu8f4KpigJDmizIs1x+8A40+O+zQncJK+rea2P/cib7oDPEox8mmWud?=
 =?us-ascii?Q?UBFpZSw+HVBq9LOk7dHR8aPAZQ/OOi0QSNADKfZtPzi7EOf6hlaKPPebqPy9?=
 =?us-ascii?Q?ahDovoqCeF66YXtWexEWc2pxmaAzxD4rIqvWtBTek95Qu+JYat+tR2zEW6wM?=
 =?us-ascii?Q?kSZIzPtTTwSfPVn7fd7QbfYytQuF7m+3sLP60xghSQ0RcJUVFUGl/SUKKVx+?=
 =?us-ascii?Q?a94Rf+v/VVZQrN5XDDvLnjQaLbDXbNuvF5UJR4mwEgvv05KB27qPLBcPkV0C?=
 =?us-ascii?Q?qVY06PtAKT8dmAGABFjg+jXUHu+aFfAJmLsMmb89nUbMt9Gcn7G31VOsYqh5?=
 =?us-ascii?Q?wAv8QN5zixxIy3sEZth15qDuWX7XX6+REP1A/hm183IWV9deMkgZi5t116jr?=
 =?us-ascii?Q?df/e5tPe5dvSbvuBedcfin61jEqiIwAG29UrE+DCpIm5JmbJ4yEaGzDZutlo?=
 =?us-ascii?Q?uySFBIDKMH8JfABgJd3cqfVL2vXclJhvMS1TeZ+t4YvHuGAWC8QtyOHeOK1S?=
 =?us-ascii?Q?6BQsU0koKIiugQavT8bGUgbdaWcDnAUVeMtfVEz61w5KyoGD0/Skj/W0KEIi?=
 =?us-ascii?Q?CdcCEN8u+hrhh6Ly70zMOqWzZEbG9fyRHfsJ+tpn8D9+7nmptZxc6d/IgW+S?=
 =?us-ascii?Q?TJgil/Gk3zrGozIlb4duworJ/xI8l3UZ89czKjNXKJye+GKmlaRbqvn5076A?=
 =?us-ascii?Q?0cjhiW0GoSdtT9+3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaaa8c7-7db1-497f-c4ef-08db08b7639b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 02:59:54.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /k8NGCujfsLF6fBH+IMP9QXvlOWnTr4a/7Qq0+iv5ghaqTHclS30PWD0Iz+QAVMYdHObNAxYpKBlkWsWAFpVEC1omSCNmiooxJYSwCeFQtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070025
X-Proofpoint-GUID: F2inXX-w7bWyZCm7ypFJKbqm-m9gl6IK
X-Proofpoint-ORIG-GUID: F2inXX-w7bWyZCm7ypFJKbqm-m9gl6IK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prior to the introduction of the machine keyring, most distros simply 
allowed all keys contained within the platform keyring to be used
for both kernel and module verification.  This was done by an out of
tree patch.  Some distros took it even further and loaded all these keys
into the secondary trusted keyring.  This also allowed the system owner 
to add their own key for IMA usage.

Each distro contains similar documentation on how to sign kernel modules
and enroll the key into the MOK.  The process is fairly straightforward.
With the introduction of the machine keyring, the process remains
basically the same, without the need for any out of tree patches.

The machine keyring allowed distros to eliminate the out of tree patches
for kernel module signing.  However, it falls short in allowing the end 
user to add their own keys for IMA. Currently, the machine keyring can not 
be used as another trust anchor for adding keys to the ima keyring, since 
CA enforcement does not currently exist.  This would expand the current 
integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
Kconfig states that keys may be added to the ima keyrings if the key is 
validly signed by a CA cert in the system built-in or secondary trusted 
keyring.  Currently, there is not code that enforces the contents of a
CA cert.

This series introduces a way to do CA enforement with the machine
keyring. It introduces three different ways to configure the machine
keyring. A new menu option is added to control the type of keys that may
be added to it.  The options include none, min, and max restrictions. The
default is CONFIG_INTEGRITY_CA_MACHINE_KEYRING_NONE. This allows all MOK
keys into the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN
is selected, the X.509 CA bit must be true.  Also, the key usage must
contain keyCertSign, any other usage field may also be set. When 
CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the X.509 CA bit
must be true.  Also, the key usage must contain keyCertSign and the
digitialSignature usage may not be set. If a key doesn't pass the CA
restriction check, instead of going into the machine keyring, it is
added to the platform keyring. With the ability to configure the machine
keyring with CA restrictions, code that prevented the machine keyring
from being enabled with IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
has been removed.

Changelog:
v4:
- Removed all code that validated the certificate chain back to the root
  CA. Now the only restriction is what is initially placed in the
  machine keyring.
- Check and store if the X.509 usage contains digitalSignature
- New Kconfig menu item with none, min and max CA restriction on the 
  machine keyring

v3:
- Allow Intermediate CA certs to be enrolled through the MOK. The
  Intermediate CA cert must contain keyCertSign key usage and have the 
  CA bit set to true. This was done by removing the self signed
  requirement.

Eric Snowberg (6):
  KEYS: Create static version of public_key_verify_signature
  KEYS: Add missing function documentation
  KEYS: X.509: Parse Basic Constraints for CA
  KEYS: X.509: Parse Key Usage
  KEYS: CA link restriction
  integrity: machine keyring CA configuration

 certs/system_keyring.c                    | 14 +++++--
 crypto/asymmetric_keys/restrict.c         | 40 ++++++++++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c | 50 +++++++++++++++++++++++
 include/crypto/public_key.h               | 28 +++++++++++++
 security/integrity/Kconfig                | 39 +++++++++++++++++-
 security/integrity/digsig.c               |  8 +++-
 6 files changed, 173 insertions(+), 6 deletions(-)


base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3
-- 
2.27.0

