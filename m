Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A4661A2E3
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 22:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKDVH3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 17:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKDVH1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 17:07:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C9B49B63;
        Fri,  4 Nov 2022 14:07:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Khv3t026517;
        Fri, 4 Nov 2022 21:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XqoF/fehRnCmGV2fUtXJvGpMOmq+tP5AH4uGuE3wrcs=;
 b=WGSundBNbd974ijJVYwcnYNdIs0Lf7hQqi7SeK3i5wJnuxCXetr/e+Ma/OeQKuEEK44O
 uVx2GWgpHCr7QehjUzOlq7fKVxiuGrQ3eUqF92N47aWHXRNzfaL/Ml3ocivxd6u4K+1m
 6oo4Lf2ghkmv3nk3txA6mesjdZyc5IiOqkruvBQmSwLSulRu7GzRexjkvuM6+TzD2TUM
 MLBoo6qPhZ7+aBBiI7Os1oA/fItZbFnS+CWipipu4/NJGhcjuVIKL/z2hq285PQrQo0I
 iLoLygAvcPOBLJ7Tgxm0QG50MmBFI0p3UQeDFznmLM4lDNkB+7zkMA9tlTFk22jLBiud OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkdg9d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 21:06:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4KrLn4031884;
        Fri, 4 Nov 2022 21:06:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmqb6nxfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 21:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R15kMYH3BR447ZcNBNbBbeoTrkBmlTmTi60dGGFESxc+ukcqrun1SzV6fg7UAIpP8eYS9uEwKW6JirHfMooMYx8wxuo/4ThHWPBJ4XfrKELrvCPK+1jr6ICUft6aOX4DrU8quXuN+e8HzK8OSOrDJbXtaRZSKZWv98YauMC72up2aoNHo3g67MOjL3iMdM3tRseT5Tntez346VJvDwC8R4aOFmjo5FGY5rPbguISWH71cw+mKqAzj3PTli5CyyFi0ONGfiEdDMnNgElmFvJEtsQKkxIDqFinqYJSetH9cTs98Ra75L38LAHQq3AR75le+koKUlpbp3+VZqEJdbwRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqoF/fehRnCmGV2fUtXJvGpMOmq+tP5AH4uGuE3wrcs=;
 b=f+IuZWLj76ss5tuWM5+4xzMrGULINnxVTVUuh+Sf68VZH+uhAcv+vKLl//zrvI7IXqOiZxN7gk7VgedtA7lsNaBJarb9ecIk1WVoSMHe4oaaOYAn7FG8hgA+0ye/kdgxDmxeizWM4liWno6a/rs1G3X3zGhF8/Id6taxp+xHziy0S87DSsmFUj4orl5GkHgC+O2LasRvjASfYn9lpF3F2WX9jKmQsz5b+9bzxuJypH8Ijh1XVeqyBysI5h/K86Rn42Wa6SoUSDXmiCxo2Nw08RTVhwsMsFhOw33mL/Mxs7GvCzNI2okqYgSiIE1mZBs2yTWdbO/kyo5pUSnRbzP6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqoF/fehRnCmGV2fUtXJvGpMOmq+tP5AH4uGuE3wrcs=;
 b=sNx/eWUzMwnrLtk3dvBJ5zK6gdgjKZqS5FVzOjUM2VkN+9U+9ba0uxPiz7/D0gzpILuWmHphGdIRP+eQPukAqzwCeWd5klv/ZU/vH1BzRHZLq/pmLd0pssNJ5YN34jH8U/FQgiNnavEaqv0DBfvqhXgV67quu+5It8IhB2gQwTE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BL3PR10MB6186.namprd10.prod.outlook.com (2603:10b6:208:3bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 21:06:27 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1dfd:68dd:1c7d:f65f]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1dfd:68dd:1c7d:f65f%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 21:06:27 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Coiby Xu <coxu@redhat.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        jarkko Sakkinen <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Elaine R Palmer <erpalmer@us.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "tiwai@suse.de" <tiwai@suse.de>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH 0/7] Add CA enforcement keyring restrictions
Thread-Index: AQHYSVko0FaTAwO/wkyht4hUdft6wK4wDb+AgACCKAA=
Date:   Fri, 4 Nov 2022 21:06:27 +0000
Message-ID: <2A078A99-880A-4C6B-91F3-22047BF90ECD@oracle.com>
References: <20221104132035.rmavewmeo6ceyjou@Rk>
In-Reply-To: <20221104132035.rmavewmeo6ceyjou@Rk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|BL3PR10MB6186:EE_
x-ms-office365-filtering-correlation-id: 7d0a8148-0475-48cc-1ebd-08dabea87016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bxvXdu2BnsuyF5yt6m+/CW2wblCDs7ou5vztKV/i7q8GPN9wQ+B3DG5fermmYTz9qal9dyOt+UEq0RoEMozgzxctA4lD5epKonG0vcgG2wbz05OWnpn2tbY16wa7UACrq/BNHIsKPZuS/OOzbQrJOFh/7KcCV9ankEEvUApKA3+mbNJuHYtaFQpP5wKsinJJ3b9IdjlS4E5hxG0mYqYqxdGuwmwXHjAQO4u2p/RFjUoCHIV4kKtMDTr4O8Vby+ZHZmdiNmWAswp5TZ0Z/d3yOg72otGcPP7H1KEa8hIqeZUhVoyMRbpDz/jkICTkFqBKagVk1a9J32HmCkXiHHkKDK2EdW2HhqP97HoUJ/ZVkoCxn3LTPEVZ/2yZ/x8Jq5v8AFSTK+DHxSwLFiRsqQRkpCdmWmiQi54IZFtci9h53NK6CBz0JTfsaUlkC3cggMEdMACfKNZzT670S7RdwKIYH5oWZzB9KUNrALf7tZuQh6ssOKeplt+ZozkqyHEgdqfNEnnDlh02A3D5w3BYP8NnyDbAlvbXgfKayrk04maacX3MhYlS87W+nbuUsQIGJ5s3FwnVL82MacVrJVSYdNUCQwoYhf08+tRfVoeYqd3lU3KcQSX58mA5tnqe21RmaibUprGKzpP12g5EdnVfM4F7pPiJTuhekbTX8xKy7h2Dt1m6T+ERfoq4BjbTddgssZy1L/jEsfHoD+NHZjEAsDClf6ExTUUlUoisd5UNAMmZPYZ4M8LiVFSHITPcorjPdV17eYZz/+h5wvXwcg62Pb0AbyORDu0UgWr3q18xvGpKEeXvWRneeRUvgJALPC/A/My4t2XMQlWhKaIOpLnPDrDdRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(6486002)(2616005)(478600001)(7416002)(4744005)(26005)(5660300002)(966005)(44832011)(186003)(8936002)(41300700001)(6512007)(8676002)(83380400001)(91956017)(64756008)(66446008)(66556008)(71200400001)(66476007)(4326008)(66946007)(2906002)(36756003)(6916009)(53546011)(76116006)(316002)(6506007)(33656002)(122000001)(38070700005)(38100700002)(86362001)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RSvJVrrR+LpK9I9IB0fqNenrEqZGBPq4WhegpoofTXhaUExSAMFt39jzEioy?=
 =?us-ascii?Q?/dkFDVFiDMfOykjnP2vrkHEqGP+TRZslGJC0WIjexq2Bnh44HTUoNDIXyw/M?=
 =?us-ascii?Q?TaLjJVd5TAyGrc/7TAdao9tRJM9mW7BGXd7xD6XFphBNDW8pBpx6Z2xrO0CI?=
 =?us-ascii?Q?wiCnIO7qE7AwrHIE4FTcbsu6aJINbF9a8UZSuumoGw4qoo5dcH4rosWzFcTn?=
 =?us-ascii?Q?uEXXVOoSqTNwqKXgyW/BG613XkqxS32lywHW15+Z0OQsRJQBqzVn809SEf1P?=
 =?us-ascii?Q?Lz62s8VzcsL0/jEsB5EAabGUwAYRe46nORaB8Mbsth1m94ensCGDsmTUlPRn?=
 =?us-ascii?Q?g/8kTiltMrnB9fJln/B2jf1TPyS4+bmVWY9Kjk+xQUvjzLluUHxMwg5mysdR?=
 =?us-ascii?Q?FGjjS/UyhhjDvIKg0CMMCKaYPwG/xUKLcTNimSP+EeVOcuJJifF+aqRroemN?=
 =?us-ascii?Q?pT7R5vERuVy8/XZ0dpkT/C3irC1uo94zbl264NWxUlgRmU9Kc1TyTNRj4p/o?=
 =?us-ascii?Q?imjFzV3UMt5LAIbL9F0cUsgufZSNheZP96S38Ea0DU6iXLlZ4j9yl9nbcCbd?=
 =?us-ascii?Q?93sCGjEROADxIg0BlLOG8rGoXpAMz8iZAW3UdVwqDeXdQlQlMAmlMcbDI7C7?=
 =?us-ascii?Q?7vB27ooP//pOKXyYNEmkpjGoFMeljrEKtmuxXxXfKjdmZtWju0yunQmeNJiu?=
 =?us-ascii?Q?gU938leXL1m1/fkpy/BrauY2AhyjnIMkSAs7kQWuWpucIgjfPgORqTy6PI7S?=
 =?us-ascii?Q?iw/LnmpegK+DJrMQssqEeLhKiQvfP3lUms1h36xR8AXbiQKRuvl7U3UOUHTd?=
 =?us-ascii?Q?SbxMmsyhegAjDTqzP7P0ClrGm0GsgSphkuG5FwleZY7kH30mhPX9DkgTUqDt?=
 =?us-ascii?Q?h5MOucSJG84myUH/4Hl0UZN7ugd5Pfkgd8AGyqX1FdLh9N4fOhzK+SbhEv2x?=
 =?us-ascii?Q?JUOYFY2O0fIomKMBO/GPephLXVS/dTUvc44C+SEsdMESglpSRoDIuN1xcUpt?=
 =?us-ascii?Q?C+8JIswX+Ah0/hvw2QGEOMl0vGQ9JZg8eMMfXlWvz6Aqywq+2+tVBbBH13Sa?=
 =?us-ascii?Q?0FD8ja+mFSIPpRD4VObN9Mg2Ac3sQHJ3CL7+O7qfLJbL5+TKIcGyCaMWtj4m?=
 =?us-ascii?Q?6jJKlf1eB85If18OdAbthmxsldaqGFzH+p6PHwbXR6xbm+EuiavQxbTrke32?=
 =?us-ascii?Q?ryDx5y2Pv+SXYAJTdrzMSozeG+v3ZS+feflVGCExRI05HoFtxQj+7ozPYYC0?=
 =?us-ascii?Q?VDmugPDbV2Goxf69fc0Z9v7EU3LSMwsHPAUApyeh84sVamLxWWKa+l3TM/fK?=
 =?us-ascii?Q?eZdlZXFqhhTZYfCa5957u1ykQ8U35g+kHKUp8tMX3P5/GExDUNOsBlaFUprL?=
 =?us-ascii?Q?9afdQKFiOvfWpIPaI830dHl29rGtF32l7Bn76Fn4pPK24HP06i8v3Om3ew9G?=
 =?us-ascii?Q?h8/ZZ3K1QNc5EewPoETg2uXx27YejhPX8KFIky7bLaCAUSrWNkZIAWunfhTx?=
 =?us-ascii?Q?NQTYV/yb2DPtZJ7b9+YILR3e/q6ZTn3gTZCTF7ko7ktzfFpKfs/9CEqLSwdn?=
 =?us-ascii?Q?ahloUYCq4JEn3nNNUcMumCcvnHXJ6KDsZuaXrCQ73FoZnYtl6xZKeIRvQmAW?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8C94C18DF374341AEDAE7337D194CED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0a8148-0475-48cc-1ebd-08dabea87016
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 21:06:27.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2XnPsqPNZQRvyGETeQR0CLRvIg1dpLOcM7sVU7URAGjjBystDnaQvQv+rgiOA6BJExdIR0BslNbQ4ud2naGN7AokAtuYYPGAqB1xM+WW6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040128
X-Proofpoint-ORIG-GUID: VUw9Aoe-7399tOoHqQ-u87bBwS4hv8x3
X-Proofpoint-GUID: VUw9Aoe-7399tOoHqQ-u87bBwS4hv8x3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Nov 4, 2022, at 7:20 AM, Coiby Xu <coxu@redhat.com> wrote:
>=20
> Hi Eric,
>=20
> I wonder if there is any update on this work? I would be glad to do
> anything that may be helpful including testing a new version of code.
>=20
> --=20
> Best regards,
> Coiby


The discussion on this topic briefly moved over to this thread [1].  I took=
=20
the lack of response to mean an approach like this would not be considered.=
 =20
If it would be considered, I am willing to continue working on a solution=20
to this problem.

1. https://lore.kernel.org/linux-integrity/8BB9D406-0394-4E2E-9B84-4A320AFD=
BDC4@oracle.com/

