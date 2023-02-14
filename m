Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A738696F76
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Feb 2023 22:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBNV0s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Feb 2023 16:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBNV0r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Feb 2023 16:26:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD622B099;
        Tue, 14 Feb 2023 13:26:06 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EL4QfW018669;
        Tue, 14 Feb 2023 21:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/1HYL8MMCL7jYUKx16WS6w9fl9Z6McQ2oL9E3sXSSjo=;
 b=VEclZSQ0Jzn1hyjvssVYwi4pEFE1MJs484ZkxjR5V3n6WVwbJPc/6eq9A5lvzgK3HNYB
 BTuzoEyRUM1ijyVUE3uQD+fnKCPKWSm4ra889QhG96TBmo4yY0M2tvhKjiK0ktX/jVm7
 Juwl1xsPuy4GS2VmKaB1AAfTTcSO5saxUq5w2fBWcUA7yoirC8yQBp2AJGKcIzbHtpCr
 vj9b0SkSaPL7U4it+QwxdNaP/b9VrYg/UHjthpOXM8M57SI+qcnUq9hhgHpYJHera6pm
 LbDWNEXolu3ReEtSgyleLxGwoYtUK2HGpYyPALeOD8aRiBi2bl9dmn/etj7bGzrkzjsI 6A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3jtxm36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 21:24:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EKB71s026975;
        Tue, 14 Feb 2023 21:24:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f66b1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 21:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOzwSHFpRPJtaXolsBV8hyn4tJHWA7wIKaLC2Aqk9bN1AzrwHMgwdLslyZI8bxDqs8nesSpgrEd2JzTLkTY8BlfmQvMmz7/clBn3PaagZZrlW06MEGZ+IgEJ0Zz25dtr0QZzjCgmD8dSENE68gEIfIIZGnJLoEauV6ZD59vSU7i7kGO/jeNkbkg7dEkeUW9ICiPwy6kQ4zMA4YmZQurTHi/2/tEIZgxmWDrZ8qUc3Ucc5/VaqVM3YV9vhUuVl4c0qZOApGjZHsQvFckgvJZz/MF/d3gjpUAHbPJ4r1wl6M5wkQ6FRje0LCrSqKo+SBrPcceqMtENuNIBWtNzThod1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1HYL8MMCL7jYUKx16WS6w9fl9Z6McQ2oL9E3sXSSjo=;
 b=BJiNYny1LhcbWHggIB3967g1Vw8tbPqzNgJ/GydtkUsw5gb7Y/0enq1LNqKbnwgzuqlR4iKBZfSpk9ZCimDr2/37+YRz7H6jT1XhTGNefed7nP3Ee7KM//3L5LwI3WUKrikQSIt3oJhPgwH8HiBprrF74lh0T/8yqZzP2eDD+yV4U2xmaou7DKB0fG6m9/BdJ7r2Wq3Y5gddWR8jeiOSj0LyjbRoXempQZ7o+64cRMvSaOUewTGeU9vuL4Tg6guCzv5JxuryMRzULVomFw4/gzjjqyINB9JqBmDnoK1Yo9i0jcG88EIXjcDlEWMeB5Rk2xf+zBXQ+0DQZT/YV38GEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1HYL8MMCL7jYUKx16WS6w9fl9Z6McQ2oL9E3sXSSjo=;
 b=OQbRBXW4LJPOC1BE2W4eK2BZyQadEKNvuhXTLl7omCcXNPyKsvscIS6S/1JhdtVPEX4zQE/iFHo7/RDXYX0S9/dORAFRlf6Wd1NBKlq7mzScekHeCErZmqBeRSeY6k411E169T89C2/Ra10hYBJgNJMG8lt5ve8d7z85/sEise4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Tue, 14 Feb
 2023 21:24:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%5]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 21:24:53 +0000
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
        "tadeusz.struk@intel.com" <tadeusz.struk@intel.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        Coiby Xu <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] integrity: machine keyring CA configuration
Thread-Topic: [PATCH v4 6/6] integrity: machine keyring CA configuration
Thread-Index: AQHZOqBI+C56J107yEO2w74T/LxRwq7IK2kAgARgQACAAnSfgA==
Date:   Tue, 14 Feb 2023 21:24:53 +0000
Message-ID: <8724445E-5D0B-4A44-935A-1DCA3AC4D7AA@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <20230207025958.974056-7-eric.snowberg@oracle.com>
 <4bda209dfc891ac9044ce847785c383e89f14f97.camel@linux.ibm.com>
 <Y+nszt7I9rGem1az@kernel.org>
In-Reply-To: <Y+nszt7I9rGem1az@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SN7PR10MB7048:EE_
x-ms-office365-filtering-correlation-id: 39cf9460-61c9-4464-d80d-08db0ed1e9e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3IDjSEdQf+ps4aAvsg33LMipfhnYe3zF44kZcsh5tgD6Scr46014nfc0dmmZAMID5LRUdfRPMQemxi2DDTERsrlOOMEIHYR52hGwUVPAuwZS1Z6hIA48OLDrDwC3LRah+37wnVeFU1prZ3sw2Opu5Mh1CFgNyApJmpZRPLuCLVf+xCAHBfCTjmCcBpI6U1cTpGiL4SBhKDGtzw9DHOOofPYaPB3U8ObqFZ53Mc9bRlcrzn7RMkuijjNysxYLMYOdrbBGCoJf81JubQqCqtATeYHO/3YiaHQq3YFpgMtCRmroS09ZCF3YRXzMX9nsS8jyC1dyCaTmo68ZjpLRXpZggOPH7aDcq3SrFo9EcTeXGAqM53Icc/zOFztwKacFeBD8hIHL5/sUexyjzDEqKFglb8fbykEfgvi8Mi6tRYPkidso55VlVDGevQIXtNBOPws/CBqjxS0vqkDePAlIGMgwwAEBF5rTQjnZSlUdFEcQBpyPur5FhQpostMAtkJjTBuJb/wjnJnJrKPs+iItXriBGNtzuxmlY5OaJAGIZp9TBQe3rRin7bdzbdEiOoA12Z7ipGgRpahsQey5SJvO/uKo4EbyVepwqkEGNSQ7RUFwWZcBIC97cX79JioCbDDQq66nmj0mznLbYI2k2A8bYdUJbuAG5kV2zpPrXMhW7l42qWqcgq41TJ57J24M5i5mbkkZEOHgpMpTQfXDsiHNhD09qChGnjcOk5vD5kNC5uA9u94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199018)(38100700002)(122000001)(36756003)(64756008)(66476007)(66556008)(66446008)(6916009)(4326008)(8676002)(44832011)(86362001)(33656002)(83380400001)(38070700005)(186003)(2616005)(26005)(6506007)(6512007)(91956017)(53546011)(71200400001)(41300700001)(54906003)(478600001)(76116006)(7416002)(8936002)(66946007)(5660300002)(2906002)(316002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?diQk3Z8DndnpJMSIiYfAg4SJNdJ6aHH5BzdIKGUAi3st3BwC9H6K4cpoosg1?=
 =?us-ascii?Q?62tGzt3yDTkH0h+MnzsokrSHk0quiOxZlS/+Ffe5MYpy/A019SnyeetLv+dy?=
 =?us-ascii?Q?bkYVKyJcfpMYxQwGTyJcaUKN6bVlKBeq/aXjTRKUTfv2CmKg7lzwXmMWm9Fo?=
 =?us-ascii?Q?b2cGDt8lgo6EzHfYySOe2WQj3nvNb2tekzTIk1HDn77S+0heDyWFizlXFUIy?=
 =?us-ascii?Q?4uDkP94N7b6hn/cHhjgpfWXkA06VrotGLLnsc7bapZFqQPY+tw6uNaSQdkGH?=
 =?us-ascii?Q?yJnBXjaLs63JDszwPDlhJ3ZSyQLefeHQugRKI9TwqXBLazSWKFs6+Aed3r4s?=
 =?us-ascii?Q?+gDU/CLdTIcbxUuo7vtOnjP/GL03yGBmj2awoV5P+NWFd8WZjl+eh8XwisxS?=
 =?us-ascii?Q?p2XxN8gv8pteDrFkQU+LKmZsJSkGtli8/A68yFPm6lUcxQG3KXJX80E1c15K?=
 =?us-ascii?Q?v1N4vTIijLD/KzKbqx3EeYmWzi1zTHd5NiHHRfnJ5GSqtYkLR2/8RqODwDQ/?=
 =?us-ascii?Q?DVbSUSd4WM+KL4U/++/58redXt3xtnEVlF1Tc3yhrYK1Z77TBbdSMMugIIVZ?=
 =?us-ascii?Q?TuCkUaHxKr278kzF6cC/xatxXAWVyE2R2YqTy2XXbxO50pM3Yt+JFzCC4Ua2?=
 =?us-ascii?Q?bI5zWujVS1FARipBi3abgHsJrkZBsbL6pzjukFngHzYHg0xtfYwDJLXg4Jun?=
 =?us-ascii?Q?I2zdGN0bdD+Llgz+Nx7O0KGsP/tfDd/Y5SLR+KPv5kUv9kQxDX1KlUxbfi7f?=
 =?us-ascii?Q?iNCMqHfoD3yZeEtZxo0xXIYpjuu63/zW1YQQCaASTU17wp235pCT/EyIgjCl?=
 =?us-ascii?Q?tUuHqRbOFpq99TMZWChcztULWbHkOB2BpH9A9t5R9KbvyyNh3qGAj7azxtnr?=
 =?us-ascii?Q?pi0mtfpUuSzmMWv3/knJs9XcBqC6eYnTNGfWvp8SWjE3G1CJDlQkRfZn6l8U?=
 =?us-ascii?Q?uLOnG5IXS1O9AeYjwJwDK2hHh6Ju9ALbPn0mk/je05n8EDwt0ZmAIztu3z/u?=
 =?us-ascii?Q?uDwQgYI6BE5BCscRgP4lYvTND7S18zj+31U0D77AvwvjhoIAztMsxaG/AOqd?=
 =?us-ascii?Q?PwVgmotq5++BGpr4omzgztz0BFjH209Mauiu5e5gLNuj7I6lWw8qaAbIYdzK?=
 =?us-ascii?Q?J3c1Fq7/+QQjTtLld+SVtWQJ5dMsWThyb2erXxRVRLtFxGsBcAk/oOl5UKrX?=
 =?us-ascii?Q?lzxhkbQXIh0yZfb5ckGSR5CQLuo/Y6XsKOAdhGTkTpUtMQQtPjqAZ/na7zt2?=
 =?us-ascii?Q?RIZM94heR+AehQL5pLhTLmNSlDkbDjL1fjbP6gOCwrIJ6SujCdZnAnsCBC42?=
 =?us-ascii?Q?zQmrk725AKcJOwf5J/NZ3SRO/khUXHH8zdapPJLIy/HWdbUHcLWRvW28iq6Y?=
 =?us-ascii?Q?ZScH97MDDFmHTP0n4UwWKmbaZhKMqxvusriKcLKwsfeqy5mU5KgG0iA8Q3SY?=
 =?us-ascii?Q?Pl5YpVqJLgszZyO+O65+pEbZ+ZATyEPrGyLnwM6wdf9H+R/VsKmmexdHMxVn?=
 =?us-ascii?Q?y0wBbYpYRr3SMRyU56PwDXdAG7dCoA6cH6F3HgnLuDynZZMHBmDLsPaPuz+I?=
 =?us-ascii?Q?Y4eF7x0Duu/hJ4mIY36OGYDRrPlWhEJBZWOCccveX/AF69IbfDvwSwBS4NPm?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CA9AA903164844484CF3144165C4F61@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UNzUkaMiwer9mBiuVWDVJ3xCcJYU1LoRiQXsFNZRPz/ouJVqFKrTKE0pLREK?=
 =?us-ascii?Q?FEbHCXEzQlCQ2Vn9+UvKq61Rw+5DCWG7l6CrCKeLJg4toPqik+BfR3wBp2VZ?=
 =?us-ascii?Q?4z0bGFoaJLXKTLBEiyiBusN/wveG3O3at8PCou3/6TVxZBzxkM1egflavq+2?=
 =?us-ascii?Q?gFgk5SDovRqxVDEDEgcOTQg4yCDQLJTf2Q5CTrUar0/wubYZ8U1gADm8DH26?=
 =?us-ascii?Q?7QZPViGOY9QdzRytK61a9jgEyiZOFBL7BdRQryvwGbnfinrrAjsC3m+pnU93?=
 =?us-ascii?Q?TIfgWy15MhKEPvtu+YUhOSdMC0rlMDWTYtxOh2vB6zGx1wQSbgOOlknzw4S5?=
 =?us-ascii?Q?4D3XEH6IKpgZ7eZWaMfWjNHDR1j47hY6lgI6vAWcQct5yxxPGBqUgPz7pWfV?=
 =?us-ascii?Q?0o4g2YNQxHDOCiOYa1EedW5lN8bgFnMXdtLxPEwslAIPXZop16CUfCoBGBf6?=
 =?us-ascii?Q?iOr8yWYqLf1y5ZjBa/V36CNol1fg3F2p22XBM8PlWsHjG6WmWPHriSjglaz9?=
 =?us-ascii?Q?a7z7fv4vUnLtkhDTZ9rVeDxn6h0OjLZhPNEOJVTOLar+h8pJ2V3f94iRq4eO?=
 =?us-ascii?Q?Od+Y2n30nyDSuKAIoVlG1yEvoR2Ii2hqYQqaIsjzXt7ak44vi6RVxb9oOmsf?=
 =?us-ascii?Q?2LGtbmWSVwgVsz5hbxSkj+fKCIqPoIdxwv1IxW66VjBYNiZrCZ+kAVCzSnPN?=
 =?us-ascii?Q?8SnjXoMDLx9j1tpPoG4dCrBsy24E6TL/vvnA+go68brdS7I8YSBvdSPTLptS?=
 =?us-ascii?Q?5qvqCZJpcYhvc82/eaW1h7us5xCQtTMp5Lg/Q5N2VKz9mnmWzKWmGFlnV4og?=
 =?us-ascii?Q?IiR3uTDv51zw1fD96CT8H7oeu+IMI4+lfr6nkxWOsyF8lOMpXOFrHs1PoHmK?=
 =?us-ascii?Q?pt/2JFwVZZHHlFbMUtPYX15IwAZsXvIYFUyNGE3g5lUVopBjYTA4M3nukhmZ?=
 =?us-ascii?Q?N1bDKNjYr9FXRIMvyyB/yzf+T72ROG7SSj36guMv7bikGOwJQL7/rPmCDSHy?=
 =?us-ascii?Q?tUzpmLEaszHAgLwuz/aJVOmW0MVF/lj25GFcKfXD1Df/1Kq4Ac1RwxfIAdMY?=
 =?us-ascii?Q?1xZg7LtwY3zzft++8d6l+iGFMtSEVbJgIcwUn0Tq6ZsmAZRD/E66IZayqqn+?=
 =?us-ascii?Q?bmMCcCmsAxEdx6G+Spk+bTiPEwwRwv0/nL9y6k4ND36KmrAIaaxyczY+xtxR?=
 =?us-ascii?Q?qe3EQ2lMeRwJhtK3zvWW1bAFDxrjQBHZKQ4vvg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cf9460-61c9-4464-d80d-08db0ed1e9e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 21:24:53.7671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkMAF8IVmF+4dTWsqo6BOc3UK/H/H9a4IvJUj5PiH+vDzLoyi1SHEt/aHozntPu0HF22yipD5Ref/Bh5YWimS0xnC79MaIFU7spnUfnuoZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140184
X-Proofpoint-ORIG-GUID: -UetTnqaKppz4oAgq7Vj22qmQ9g5_1sB
X-Proofpoint-GUID: -UetTnqaKppz4oAgq7Vj22qmQ9g5_1sB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Feb 13, 2023, at 12:54 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Fri, Feb 10, 2023 at 08:05:22AM -0500, Mimi Zohar wrote:
>> Hi Eric,
>>=20
>> On Mon, 2023-02-06 at 21:59 -0500, Eric Snowberg wrote:
>>> Add a machine keyring CA restriction menu option to control the type of
>>> keys that may be added to it. The options include none, min and max
>>> restrictions.
>>>=20
>>> When no restrictions are selected, all Machine Owner Keys (MOK) are add=
ed
>>> to the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN i=
s
>>> selected, the CA bit must be true.  Also the key usage must contain
>>> keyCertSign, any other usage field may be set as well.
>>>=20
>>> When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the CA bit mu=
st
>>> be true. Also the key usage must contain keyCertSign and the
>>> digitialSignature usage may not be set.
>>>=20
>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>>=20
>> Missing from the patch description is the motivation for this change. =20
>> The choices none, min, max implies a progression, which is good, and
>> the technical differences between the choices, but not the reason.
>>=20
>> The motivation, at least from my perspective, is separation of
>> certificate signing from code signing keys, where "none" is no
>> separation and "max" being total separation of keys based on usage.
>>=20
>> Subsequent work, as discussed in the cover letter thread, will limit
>> certificates being loaded onto the IMA keyring to code signing keys
>> used for signature verification.
>=20
>=20
> It would be more robust just to have two binary options for CA bit and
> keyCertSign. You can use "select" for setting keyCertSign, when CA bit
> option is selected.

Ok, I will make that change in the next round, thanks.

