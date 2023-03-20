Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98CD6C20EC
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 20:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCTTK3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCTTJc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 15:09:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B02D62;
        Mon, 20 Mar 2023 12:01:45 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KHEYEA012408;
        Mon, 20 Mar 2023 17:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JKF3ArhGNIueVHMH8Mod3U0rvM1lbAstWX1xoLJkfzE=;
 b=eA5/dIkHOFrhT863m8jDi3pee0GX1IGgGOknV/BF/U2Y+p3DeirpKDswBYMWiVVpp0V6
 uCgCJNy3b24OtgBdGlq8iCz08rTQyDezmio3DM1+F7QV18/JSvVSTnYpmLXTKG2jPGst
 Geay15xsrr6zMKjx1A2pKndpft+54zeLwo8lyu/0yWS2FwmWRweRnvX55gYKYv1ZzoWF
 5C2Nwuo6HLN68Q4laae9IqgIqn+7youON/xV633rdcNtP7HbVIQcJ0J+eWDFaTGmBZaE
 X2K4L8DnPXhSTul8ws86h3ctpuFbYnxc84DA8GnDyJUyHxjoDNvSPUE+5qDogZMGLFir BQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tm4w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 17:35:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KGkJqA036876;
        Mon, 20 Mar 2023 17:35:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5nmgrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 17:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEw6eVTYOfkR6SWxYrAKMsR9Q51AheAWww1Q/HGfvm4Q043kQwpUHaPGa3URgX0rVHkMIw4qp5bjCAVRpJZWYxEFa/oCyxW9hWY2qxwVdgnis69B+b1YdSq1VqotCsTSn4+58F8aUjqcRtzq+oNi7qAmqpI6Lx/QYSc6RILTQ+x+AnqMnn5bodoRt/hykbi0WIf01kxXkxK5Jl192/sKM8/RLM5u0AuRwdBmTQq3O8RoEDH/faKQVukkYSMAYfsqHHEA4kbyu/t6oOSq8iqcVBZRuHZmvSl2EJIjJjt36aTthOaaA51ALvXJLvhGXHJ4DVs2FjhWg5RTx39Nb7OJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKF3ArhGNIueVHMH8Mod3U0rvM1lbAstWX1xoLJkfzE=;
 b=djSMKgM4YuGxVDHlUfPDhxd2fR+vP5L2U+0glB28aIz0DMY4JY411FTo2mIRpVT9deGEYVRss2iQ+Z9lyeMUNX05kXvq7LevA9lG+htlKtDWmP1Po7jqCg04myeW0eKuTtPiJvaQqxzkI+qD4C6ZkIq/GbjngEyUtmHTLyWipnnB4jcvh70o0JX949JsMInwpxUlINQDrZLLqZh6cQsBcUe+HYjetpPMk1GQ6rdVoDolI/6Lw1F0qKJaPSpwktBdkOQLVVhskEkmTONoulVWxU7+I5cVOY+pDxp0klErBQIGYpJutNh95xG5eKhSg/I20qf5qHbHQsfpjJT8cSGXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKF3ArhGNIueVHMH8Mod3U0rvM1lbAstWX1xoLJkfzE=;
 b=KUZEfJl1hhCNK/sq5JUzf0c5ySsvrBvGE1K0FglnQwzzctCNxXHx8zM08f3fgV2zkGJsRlH2O6+WdcnWpwk4hWmDOd/docnUw7V+b3HjWbWnHks3gpmnCgq6m9CUwhL5Tw/ObZfx5GWYGxUxqYsb7iqJwLvJelW1ncsDnHZnBGE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ2PR10MB7583.namprd10.prod.outlook.com (2603:10b6:a03:537::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:35:01 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:35:05 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "erpalmer@linux.vnet.ibm.com" <erpalmer@linux.vnet.ibm.com>,
        "coxu@redhat.com" <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v5 5/6] KEYS: CA link restriction
Thread-Topic: [PATCH v5 5/6] KEYS: CA link restriction
Thread-Index: AQHZTSadjQtL2N5CiEKWrhYXc3GnW672MjAAgA3YHYA=
Date:   Mon, 20 Mar 2023 17:35:05 +0000
Message-ID: <07FFED83-501D-418C-A4BB-862A547DD7B0@oracle.com>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
 <20230302164652.83571-6-eric.snowberg@oracle.com>
 <ZAz8QlynTSMD7kuE@kernel.org>
In-Reply-To: <ZAz8QlynTSMD7kuE@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ2PR10MB7583:EE_
x-ms-office365-filtering-correlation-id: 987cde01-3b63-4899-df69-08db29697167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zPwi65crKx8vQ4BUsMG+WmAF9ITty1dn1/7SXEinTCZmfI5gHbL/gfQgLqdvZCl71M4MhE3RfII2GktVUfx+eu0W0/849qnqEYu8bRRhRIeSyFwNSgpjINzpgbw00hzZlcT2RdqthmZBbBI9ZLp1oZ1kryArvVKABJfW7XW1xIqxbLaMMokW0RDprDPX7V6dyEQ2JL8BhJEh9F+mgeef379Q4o7OUPnchZn2z1kbZ/n6ndvQ9rMb0BTxFzkqfx3qlYlQfrD6DOwKFuBsUk+XjoukBUaKfXAWoQNx7P1+xlbj//hKLSpaSUtjuZooapLriv8k4QKbdNppr9wpvzDZbiVBKFotAbgn+VjF0vgFxbiOFS3ch81ekJNqybbuC9AScvi9SeoLIfg1oWV6X6kIZHDhfcUm+TPSJe8YKNPE41x3cgbuL1AqSZbdP/plzownzZilg89OytW5J4CFiJy5+6f7OxhNDK07SBVaxXw8t8nQBmW7eH30SnEzFfuGmv2tU3eFN5HacK5fHc30s6ZOr5meePGiBnMgfY6InnAnjTnCettUg9gg4107KyYOSdVb5WxU1c/IgA6bKVmTfrEcTc4W5rOj5PeSDff/5ktMAfJm4kgongX/8GnW9JVyfHG0QFlIlYNC4EGmKvY8xf72jIxWbrwNhVmdfiNjmwzX+0tDvdJ9a0XaymjIOf3KQiiH68YviovmJ9HPDWh8B14Rq2xHQ2YKmsIAQw0viVTW25E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199018)(38070700005)(2616005)(6486002)(53546011)(6506007)(186003)(6512007)(26005)(71200400001)(86362001)(38100700002)(122000001)(478600001)(44832011)(2906002)(8676002)(91956017)(33656002)(316002)(54906003)(41300700001)(8936002)(64756008)(4326008)(6916009)(7416002)(76116006)(66446008)(66476007)(5660300002)(66946007)(36756003)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L9P6q3S1q7T03s0bne8D4BX93J/vxphD5GvUpQU+u/cZ6+Y0/Tdn4KrjB+5Y?=
 =?us-ascii?Q?mP8K9yfPMxzrzZ5CK3r0dcnK4EM0ptKVERceRptxPT8bOn2OSwFNhqwaOgXK?=
 =?us-ascii?Q?WwGiza6eXgEp/BAuz4+jxuW9E0XKXrPSE/2rPe+rq3++B55ETHg5rNIBMnOI?=
 =?us-ascii?Q?d0ujaNrBrGXSvV61ZzM4qoP9NnlqSzEN0OU93tQ3RtRgxKfCwu+hHuEZcioI?=
 =?us-ascii?Q?giQwPird8Xouyd39VBVHBqhx0R5zSmbGDCAzD7+5dRIZhQcr9otoG0ymIvCf?=
 =?us-ascii?Q?7qd9+Cx7oWMz8OOQYfR1qRnIG+NIoHYYNTJ5uDF3lz3sQwvwOtCn/v9Dlrzg?=
 =?us-ascii?Q?bPAVxkNenvqTyZl3YIiDSkwCPFUFCDRpKifG7Ttu52wjGhhoWMpUIS8KmXXd?=
 =?us-ascii?Q?tUvJVYd9mKqHj210RnmdjdoP8+SvAjQDCfLURnQ7sDm41Cz7hJ4cu+TKxlQs?=
 =?us-ascii?Q?xHl/HPC9+cdepZj2jODUqzwwGYvc8bkM9yDrCjb0jvrryqDCb8Q32vVRkoZA?=
 =?us-ascii?Q?nxtAen7D/eokzioZuY0JxQ5SBg7H1vGBh6T2X0wZYjjk1iQv049DZLrjJl5o?=
 =?us-ascii?Q?7an2zvO9hivMjxedMTgN+DDQq8irJUR0q80TcL5zw8c90PbjHPYdbMW1OvjY?=
 =?us-ascii?Q?LGLpfkXlmawysKoVEZ3c3/eiBjWzIlvEbZ5k8OsOSjzd6ieRHJyFWwUVwKe7?=
 =?us-ascii?Q?4IYx+7fnyVoc9x439U1aBgsEX3va+yhjlBowJB7LvTy/AwFNoWaygj/mJ/ph?=
 =?us-ascii?Q?6kTd099eee0cR2NXlNydPVRkMvFJmSZQA+EVI+P+AR2yVjlnq2wBHb8rbYjI?=
 =?us-ascii?Q?KIPYdNysnvs7k9iHKHzin6ptd4U7g1qvev/9HNE+SCtqQLs8KF7gDqshb8UU?=
 =?us-ascii?Q?fEuf1duKxD54tMi8w8lY5AZu040oGdpd1p4f4//4HxHn2W4VTg2Owbh0Jb+q?=
 =?us-ascii?Q?Qi2AXNxyTIXmOLlDH0Vurci5o6J+eXRR05CooDxU6XTHcTvrizwqGFBNHDKI?=
 =?us-ascii?Q?AJrC2YeJO/+6Mwm/rL4SvOzsh5xniZkafGF5fw5gH47UNkv4BRQ6h1mD60yr?=
 =?us-ascii?Q?WDqYQBc9xjxqqG1QpWyDZDorvLXOHvzeOkjAKX+J+REIWvp+f5APMfSLn2WF?=
 =?us-ascii?Q?9YvRgJw5fPWjNsE7tCgmCs5EcS4HXwBbNGeLmiZRAhPfQ8ewkO9jVJ3GT8AD?=
 =?us-ascii?Q?vR0QfDPF84bDlO3QJzQXf/cvCSKJ/fIdTJPZSCBazUeO/tQos5YSEqzpSy4h?=
 =?us-ascii?Q?yCBRiDjNuhqUaYNVIaaaNqJr5Kc19zy7kT3kep/JyXjpI27eIJnCpJVJARaZ?=
 =?us-ascii?Q?iqe0DV2MHRtzKxqt8jdqPOySy6qrjgWq7T7OHj3SPqloANVLU/AV8sMoDw6H?=
 =?us-ascii?Q?3RUY5G+naFcRuT6FSZummLUVzOFCqBRR2Lbt80gOEvxzp9Axo4kIdrbuAQFH?=
 =?us-ascii?Q?QD8WNDKN9Ppi3W0+Xfj/WhNU+H1L0NRp2eBC3FRdV8BAT9kUk5cz2MNSjq0h?=
 =?us-ascii?Q?HYzWMnlQeTutXYwmB3BP8MOhsGrE5nHBNFKxEGOy/iRiT3U/aEMb3/CQmxX/?=
 =?us-ascii?Q?QWxJ98i8WC6P92mLaU92dfRJS9qT63/CUXndBbYPyKoD3rDRMtI/7vrilJtk?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DB48034B6D25C4DA8918740313B6A7F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lWJ5l5SMSIlCBHDxIGN82YabBeA579F06JmpWQQ2F0g5dwysb5m1Z6d5UByv?=
 =?us-ascii?Q?Wx8pLe/66yfTWLj1ffb46O6VtFGRJzdzhqVtQ2l/iruqWUsVQrSyElNcmLEn?=
 =?us-ascii?Q?Vm04C1aY0eCXiYTrI1ljWQ5/YZUdqFbulGC8OGWM/Ul946g5vSbblOA/opKi?=
 =?us-ascii?Q?mqLdf7sqmbkJyvd8y/VHDUbSD/sGmYHVi2ui40ln5Rk5EIi5eHEbWhhID5zC?=
 =?us-ascii?Q?MCZ9w0Epb569dMHFlN43hvXhq72TPtS5e+NLAtlXooMbhf1GLt9lPPfN1mgy?=
 =?us-ascii?Q?kfA1Y6nNx3ITTJtMrwedXTuEK8GrqiLel7LkdEVE18IHz6fU5D8NfI8SFtEg?=
 =?us-ascii?Q?LqQAX7p0l/tacbxjzf803LdLlQQ+l2lLsONSfpW+oDXIbUH0+NxI7T9st+6P?=
 =?us-ascii?Q?ENM/gEKXz/KTA/mB3SnCzDCcqYMbZaqmIavEoBKDzcChpKvrRlKWUMMgFgZD?=
 =?us-ascii?Q?xVxenQdgyBmkSCXm1o3BRDFAcV+rVpq1qO8wbdgMuIKn6gyzIbSudDud6rWD?=
 =?us-ascii?Q?LD9cabPK0aLkwiHo+AOY8Cml8LSDFipZAZAwm7RWo2iRKrk9Zn91GbpR1ico?=
 =?us-ascii?Q?192htIHnDGKs40McmNDNb2r0/ch0nm0MF+9mSFBHOwIqYZt6wgd3H2zaPwbe?=
 =?us-ascii?Q?cMkXQhSfMdFlH8p0QvsLL+RiwiPG1cixSmKlPVR73ZCreft2hpIefrpxNPuz?=
 =?us-ascii?Q?2f4Hi3zvjnP59m1CNcDgYg4hTB8TzywDsx7cH3HqXRdrm/ZcnCkII8z7GhmM?=
 =?us-ascii?Q?3BwqkHIDY8J6lJGwGOkodJoENapTNxTZLEowF3XqSrYssNdWf+Fs639630yP?=
 =?us-ascii?Q?5CKNOFhmMsuZg1BYZBoJrKSO83tW4vk3OrQkPDsiiqURMyThLTwH6VgCjlCL?=
 =?us-ascii?Q?umAE+eLQ4f+DoiKQvaZPHEG8HksnuSA/AkOkuXFc/IWgyUFaGt/cZckHDNJe?=
 =?us-ascii?Q?n02JkFjTYweTeml0ORzOWsNPoAhCzCqNolo2IBgjPtFBKyzxRwBF814lLoJJ?=
 =?us-ascii?Q?ItS7AOxPs5P9WQFnFxakUnzYO1AkeDrkP03gpUj5pMJDGtuze+INJBQyHDXj?=
 =?us-ascii?Q?BSo7nIAlP87oZ8+0/4Z3URFH8QGCFncWj22469ZvFRo0RQUtvrILzLH+uuwL?=
 =?us-ascii?Q?Co216h9DjDSHtS2mWmKmnTOf239sSR8soOJMPCE4VdfiEMf+P04jrW8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987cde01-3b63-4899-df69-08db29697167
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 17:35:05.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmKHdGsMYRidUi8llOftPu+hfoYS5T9ei1dlImPy6xUZ/bhRN1E6IsVrWuwvSDVourkXSpQG1sMN2dgHsUB2EYRFFQihaiQuXF1S/6q0234=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_15,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200149
X-Proofpoint-GUID: F2oAjJPYKzYbEBSIbZ8qY2UoszzLUHzo
X-Proofpoint-ORIG-GUID: F2oAjJPYKzYbEBSIbZ8qY2UoszzLUHzo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Mar 11, 2023, at 3:10 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Thu, Mar 02, 2023 at 11:46:51AM -0500, Eric Snowberg wrote:
>> Add a new link restriction.  Restrict the addition of keys in a keyring
>> based on the key to be added being a CA.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>> crypto/asymmetric_keys/restrict.c | 38 +++++++++++++++++++++++++++++++
>> include/crypto/public_key.h       | 15 ++++++++++++
>> 2 files changed, 53 insertions(+)
>>=20
>> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/=
restrict.c
>> index 6b1ac5f5896a..48457c6f33f9 100644
>> --- a/crypto/asymmetric_keys/restrict.c
>> +++ b/crypto/asymmetric_keys/restrict.c
>> @@ -108,6 +108,44 @@ int restrict_link_by_signature(struct key *dest_key=
ring,
>> 	return ret;
>> }
>>=20
>> +/**
>> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
>> + * @dest_keyring: Keyring being linked to.
>> + * @type: The type of key being added.
>> + * @payload: The payload of the new key.
>> + * @trust_keyring: Unused.
>> + *
>> + * Check if the new certificate is a CA. If it is a CA, then mark the n=
ew
>> + * certificate as being ok to link.
>> + *
>> + * Returns 0 if the new certificate was accepted, -ENOKEY if the
>> + * certificate is not a CA. -ENOPKG if the signature uses unsupported
>> + * crypto, or some other error if there is a matching certificate but
>> + * the signature check cannot be performed.
>> + */
>> +int restrict_link_by_ca(struct key *dest_keyring,
>> +			const struct key_type *type,
>> +			const union key_payload *payload,
>> +			struct key *trust_keyring)
>> +{
>> +	const struct public_key *pkey;
>> +
>> +	if (type !=3D &key_type_asymmetric)
>> +		return -EOPNOTSUPP;
>> +
>> +	pkey =3D payload->data[asym_crypto];
>> +	if (!pkey)
>> +		return -ENOPKG;
>> +	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
>> +		return -ENOKEY;
>> +	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
>> +		return -ENOKEY;
>> +	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
>> +		return -ENOKEY;
>=20
> nit: would be more readable, if conditions were separated by
> empty lines.

Ok, I will make this change in the next round.  Thanks.

