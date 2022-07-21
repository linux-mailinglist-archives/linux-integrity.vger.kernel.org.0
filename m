Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6036457D71D
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Jul 2022 00:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiGUWx1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jul 2022 18:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiGUWx0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jul 2022 18:53:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051F18CEAE;
        Thu, 21 Jul 2022 15:53:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LJfSOQ022522;
        Thu, 21 Jul 2022 22:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1ygMr7w21ol7UW6//JzP2g8qOwtFevb+Bu+Khqjbuhw=;
 b=YrAyJoiqkb3C3Ev8GUTLQ888s0Gg7o4UgBeV/BXv3Y3jQ5FXElvGvzpDUNeLbOKOHWYh
 5vcs1/lo4aVbF9iZdBDpRi41R6hg0dJqJulIK7FCtpkN7O4p4MDt9192HYpR8SsXeH4K
 hGAiEpK99NmY1whqLYGDzrzAqsau665dvltgQKgXyBqdYyBTi+TVbITzLpE4OsMoiqpx
 rKnomfFYy3zEmiq8SO9//uyA+QB4ZtvWpJbMLW7f2up3VmicOj9nv4bzxLc291iE+K3+
 xHL/tjqMHYoTEjmF7FkP1vngD8D7tvyt0MWyK80KgIcJHy8SiaaPNo8lCX2MwQqIQRwv cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42p019-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 22:53:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LKVDoc002842;
        Thu, 21 Jul 2022 22:53:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mdq28m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 22:53:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnJEi3Z65zhBCNEhv2pmJNaYN0oCih1cF4/f82ExuABaImUsQ1LkioPqEbhTmp+aakqRa/CX/y5sGFq19IicVkv+PuvWa8GNHvXPoJWCELOWBObG5WEybwivxGgRHgtMORLOYGvXtuTmupa1wJqG/Gi039kCkI6VWt8C4U0vbZtXVgNwaqrsXm5abzQ58xqkwtmlzUaA/2DhMhFiOVSv4F0GeHfpfWZ1y1a0AF4dLzvpwJ3P1CR0OUwNt2+9lcuqd8aOl/lb2QHASQehXWXSldVOag5EmndhX7KoD+mHE3XuU4F32/lxM64z7UH3EC8UJalk2t/YfDJBItD3Ws100A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ygMr7w21ol7UW6//JzP2g8qOwtFevb+Bu+Khqjbuhw=;
 b=COn1R6LDhya/KmrsCKY9fG3DiiFTS+ob7rq5FPGUR2dlP9qM5ELLZ30gBg+XQn23tb29eBIWyCujvqlmY+0gUO+1s1msk8alEbsOkQzPR1DDtToLiIK0Tl8zhRU3vdiEpCAhYbIbT9cI4oN0pH3E//SNQVkDLbTth6YOruYaka2m2hnyrjlREDNcYZamhoFRNmZDn102XmtiQNMn4sp9hdInZI1+VUot1bUFKozlLAXsz6jISS65/TXH5z3SNW/dzAVOt0c+8VUnY/vpH16kWcy4a70QgrSQnhuf0XatTz4gq8Pf45dHESkH5DZC/9ul0J9pLn+17XrswtlTQaAohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ygMr7w21ol7UW6//JzP2g8qOwtFevb+Bu+Khqjbuhw=;
 b=TS/FaClUNdmDSEH0YVq4vr4le9/LLLS1AQY9p7fiZuzSikIOYNyA5qTGIuTaQWOicJVrjBAgxpkQQC+Kc5j7gPriVZqJono0TOFcTs7X3zYcxaeZ0BjUkbOEJ0j9iGKDYcXFvoHeblovL04WhrsVJJgiXLvNPkgT32nUnorB1Ys=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 22:53:08 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::21ce:9dc9:abc2:dd08]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::21ce:9dc9:abc2:dd08%5]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 22:53:07 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Elaine Palmer <erpalmerny@gmail.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        Dimitri Ledkov <dimitri.ledkov@canonical.com>,
        Joeyli <jlee@suse.com>, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        jarkko Sakkinen <jarkko@kernel.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: keyrings, key usage, and trust models
Thread-Topic: keyrings, key usage, and trust models
Thread-Index: AQHYnGiuTnTy9OJThku5iSPcWAY7Za2JcHeA
Date:   Thu, 21 Jul 2022 22:53:07 +0000
Message-ID: <8BB9D406-0394-4E2E-9B84-4A320AFDBDC4@oracle.com>
References: <e3c62f26-861b-57c9-4d86-6af68c3433b0@gmail.com>
 <de0b6e61-2f6e-c215-65a9-428c3bf1bfb8@gmail.com>
In-Reply-To: <de0b6e61-2f6e-c215-65a9-428c3bf1bfb8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85331042-3ab9-46ee-9ce6-08da6b6bc781
x-ms-traffictypediagnostic: CO1PR10MB4593:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtIa3X2qp8EV/GsvtGHZx+qNT3d9sceZ1diSU16LDPMYjE4XZd0l8fnyXJmYFh2w5/4KWrwt3pw3XXqSbtPlHxqlULRJieqVtX07SsUtzM4JvqI0MbtAfVJXFKqlbdecfItE6oX5sRWtgWOKYa+BsfW7j10E3mWjsnYHw201ktxlyheo/TtXJCbPHxaG18EhjKzOURiG+B2fxAokb/r9HWMLpD5yN1iSg/iVMcku9aXZs9Yk7/vwqvNXIN91HJN5UszW63vw67aCuw+eyJpuI7+c0Uxi/sgc5MEGlKMyJBIKph8D23oRhP72LrXlVAH5R0IfaACU1TD2LJA9OoDMiAfysg06Ao6m4NfYU//V4oc1ghQATh6QWAGHsnXcDzHlouRZYCJYqVrb3egSLW53ZR43yQmi35RgHesTi4v6dvJp/t9WbQyp1adM/1TXT8AVsjU+a38Pql86w8y/FXBKOMsn4Syqdvacc/apWteoB6kH/MVxlE6ioJhrZRUJPba+tTdHatOxdRl7lz3WVwJrPrUNg1mLaODEekgNrKoM23qnyV+hp3MaheeCfK8dKQMugOV4wLuesDOjWLwSiMhtHMTba/1xRgM3hYRLTW36ZhjcTlwYZ6jvGAiEs7vADk5QXSd8zl+AbZDPKDW5ytZlfCXs/CQiehuQ3EG9CRvvArTz5pn9MDBs2W3Q6+fbEeYsv52++qwuP9mO/K8KrcKZiyRuqeICfPh8YpghbtW9g/609PkTkWItb56pwfVt8oRcXPudsJtQtq2vtIbRxXBS9BugEUgFJYTD3f/Z/SxZxtX5dmUCwZVqVgA2eYMkU/Y2gkKlw8TDFBu5CFEnlkhq0SSx99POTRAekGrQ3JcjxFB8SCoCc8wjgiIhefijKStr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(346002)(376002)(136003)(86362001)(2906002)(26005)(41300700001)(6506007)(53546011)(6512007)(478600001)(44832011)(122000001)(966005)(6486002)(107886003)(186003)(5660300002)(8936002)(2616005)(38070700005)(83380400001)(71200400001)(76116006)(38100700002)(316002)(54906003)(66556008)(66946007)(36756003)(64756008)(8676002)(4326008)(66476007)(66446008)(6916009)(33656002)(170073001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW42V3dqNHMxUkc3NlJkQ3JoUHVoOEwyamc4bktEVXBldkZ0YXFNZzh2ZmM5?=
 =?utf-8?B?OENsTjU2b3c5OHNKb0o0QTJJNHl3OEZISk1PQ2VqcVVQZ1ZpZS9xMDRlSDVK?=
 =?utf-8?B?aDFIU0ZtbEY1RzYvQXA4NzI5d1dkZ3FHWlNYSngybXd5cG9SQ08yQmgzb0dK?=
 =?utf-8?B?eHZwU0lCV0xobzVnSTEwTTJhcStJTGl1RUYvRzRIQi91Q0lSZ054TkJxRFQ2?=
 =?utf-8?B?Lzl3aGs1Rm5QclVyZEZObHlYMEkxZjE0RzNHR0llMmZ5QkF4MldRMFJQRG1N?=
 =?utf-8?B?aDlzY21CRjdMc0hDOGxMcm1pelRaSStadlc5M0V5TUxOVExlT0JkVWdxKyti?=
 =?utf-8?B?MHJTUTZQWk9HcERmMFVwQ2RMeXVvVUV6VitNTEsraWVCNVVYQllnYStpcHdr?=
 =?utf-8?B?eU9jM3dld3VQV0xlaEdLSUdlRk9RSWNJVkZCS3hqU3I3UjlaVzRzRGJUYTJa?=
 =?utf-8?B?VndPLzJsM0VEeEprWHBUNVFQeFdEbVgwd0FxNDZLeEF3a3IwNjVaOFBYZkt4?=
 =?utf-8?B?L1c4bmxtNjBJeC9iZloxTDBkbXUwQ0NkKzJLbG1vczM4ZnVVd1c4b2VQRDZv?=
 =?utf-8?B?M0t4N09OQ3J4aEZ2NTM4bHR5QnUzRmZGZTQ5Q1hHM1IxYzdzVFpZbmtvdm83?=
 =?utf-8?B?Si9YL1J2cUowWWE1M2tscjVRVE5DTzI2TnVNRW5zbjdBZmVjbklhSVB5aXR4?=
 =?utf-8?B?SUtCRTF2Y2o4QjcrOTVwVU9UZzBwbjYvRWFObWFxNUE2UFBtdzVPK243Qk02?=
 =?utf-8?B?T21pNk5lRExvK0llRGR0Y0ZsNDNpRmtLUUsxWTM2RE5KZWQ3VU1xV3VnMjZ5?=
 =?utf-8?B?L0UyYUNiVTRMbzdDTWJPT2x1YU81ZGRTNXVkdlFqV1YwcmNBVE4rVCtOamcr?=
 =?utf-8?B?WDFLSWFIMU1TSlpBOGlPbENlL0s1Rjc3N2J2TzJER3IyWU53NWh6RXpnOUlu?=
 =?utf-8?B?TGFzME92VEVTeUQyV1JIazdMN0dGdXo5KzZHdFM2NVRwUlF6OFFPSlIvdXpt?=
 =?utf-8?B?d0Z0aTJSdFNsTVBab0tvSXlrdnNzclUxancreEVHSnQwT1NSSjVnVDVvUnBT?=
 =?utf-8?B?cWlCdlltZXFVL1ViYXhjc214VXNXQkZwLzBLaWJFRzJlTFhrMXdxM3dMQ08y?=
 =?utf-8?B?MnFIZU9aUExFVlh6NGZyekd0OUlheXhQekp6S0hUNUNIT091Mk96dWJnaUZV?=
 =?utf-8?B?Y016blJPeHBhSktnR2tIRTgyVHYwVUxaRFJCZVVvRHMrRG1XaXBFRzh5cmZa?=
 =?utf-8?B?Y0VNV056K1E5Ky95MlZnSlJabVlnSXRyRk10dXBRZFlGS3RXa3Z4aFZxY0F0?=
 =?utf-8?B?OU5lUDgrK2lxZEFkeUlsdDZaeVQzMDFiOTBPV3lRa2puWVlJU25nRGFnQzk1?=
 =?utf-8?B?c29XWE1JRC8zTngvdDVqc1l2VFdCRXI0a2tOOU4xTjYzOVlSM3JYNWxRV3NV?=
 =?utf-8?B?dFpDTmQ4ZGJyeUJaRHJFaUd2cGhGdjJhUDF4cDYyR3NIbFFzUGZJNmZpZ3dH?=
 =?utf-8?B?YkVXanFFNzdEMUxhTUpWQUhEZGlqblZiT1ZPdTQxc1lCUjExZlZHa0JUS1ZS?=
 =?utf-8?B?UXJpaGZKSFhRYVFsQzJ0N3hDVjhBL1AyT2o0ZDA0b1U5andEQmNpNUUzWm9j?=
 =?utf-8?B?NGRNU1oxT3U0MW9ETkRZSmNIcHowbDYvUVZJWmhwY1ZCM3RVR09UOGJuMEJw?=
 =?utf-8?B?OUxlcFNzNzM3ZW5WWms5MnlSZ3RiV1BlalhBamtmM2llMUVDR2U1QXZNVXhT?=
 =?utf-8?B?NnpXYWYzWnRWYzJ0MW13Rmo1THpBSWhHQVlVaUZwNlc2ZWtYVmg0UmpNL1Bx?=
 =?utf-8?B?R3dCZ0Z2STFleTR6a2UzQjBvZHkzc2xRbkEvN2JKbVJBaExMbVVKaE5TQjR6?=
 =?utf-8?B?WFBkdTAvdnRvQkZzcTJYelQ2NUpWcW9xTVpnWG8ydU5MenQ3TVhublR2TkJv?=
 =?utf-8?B?K1gvSFhvblRyMks4YjVZdzhTM0Fud014UkhGU3RUb1Z3MGoxNExTTGlETEJ3?=
 =?utf-8?B?VmE5b2hLSm5EQjZSOXlwY29oWXlaOHpxNHFZK2JubC93Zkd2WWtGOEQzcVNr?=
 =?utf-8?B?VVlvdmpWTDdtZlZGRytuQmt5TWdqYWsyU2xiNW00c2xJZlNGR2hocUlHWVRz?=
 =?utf-8?B?ckdvOWR3S1M3RUp1NCt4ZTljVFJNbU9FOTZUeG9Hb3B5dmZwWGQ4aGJVNjlH?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF1CD9734EBFD746B4D49ED9A47747BA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85331042-3ab9-46ee-9ce6-08da6b6bc781
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 22:53:07.8710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XOzXNWznBZiR45XQWAKOaUkljHegMSM5eR5iGjGz+yPVz8Q2zkys9/GqGLuYuAdyXtNkGKmoGFhGtpbI4EECpW0JpGBNM2ZdPYd1jBk0Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210093
X-Proofpoint-ORIG-GUID: AmFl3JIrvTzdiXQ5BQx1JspOo_w2-Inr
X-Proofpoint-GUID: AmFl3JIrvTzdiXQ5BQx1JspOo_w2-Inr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gSnVsIDIwLCAyMDIyLCBhdCAxMjo0MyBQTSwgRWxhaW5lIFBhbG1lciA8ZXJwYWxt
ZXJueUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IEF0IExTUyAyMDIyIE5BLCBhIHJlY2Vu
dCB0YWxrIHRpdGxlZCwgIkVzdGFibGlzaGluZyBUcnVzdA0KPiBpbiBMaW51eCBLZXlyaW5ncyDi
gJMgSXMgdHJ1c3QgYnVpbHQtaW4sIGltcHV0ZWQsIG9yIHRyYW5zaXRpdmU/IlsxXQ0KPiB0cmln
Z2VyZWQgc29tZSBkaXNjdXNzaW9uLCB3aGljaCBpcyBiZXN0IGNvbnRpbnVlZCBoZXJlLg0KPiAN
Cj4gQmFja2dyb3VuZCBhbmQgY3VycmVudCBzdGF0ZSBhcyBvZiBMaW51eCA1LjE4DQo+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBUbyBzYXZlIHNwYWNl
LCBzb21lIHRlcm1zIGFyZSBhYmJyZXZpYXRlZDoNCj4gIA0KPiAgIE9mZmljaWFsIG5hbWUgICAg
ICAgICAgIGFiYnJldmlhdGVkICBPcmlnaW4gb2YgdHJ1c3QgLyB3aG8gdm91Y2hlcw0KPiAgIC0t
LS0tLS0tLS0tLS0gICAgICAgICAgIC0tLS0tLS0tLS0tICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSANCj4gICBzZWN1cmUgYm9vdCBrZXlzICAgICAgICBTQiBrZXlzICAgICAgaGFyZHdh
cmUga2V5cyAoaWYgcHJlc2VudCkNCj4gICBib290bG9hZGVyICAgICAgICAgICAgICBib290bG9h
ZGVyICAgU0Iga2V5cw0KPiAgIGtlcm5lbCBzaWduZXIgICAgICAgICAgIHNpZ25lciAgICAgICBi
b290bG9hZGVyDQo+ICAgLmJ1aWx0aW5fdHJ1c3RlZF9rZXlzICAgYnVpbHRpbiAgICAgIGtlcm5l
bCBzaWduZXIgIA0KPiAgIC5zZWNvbmRhcnlfdHJ1c3RlZF9rZXlzIHNlY29uZGFyeSAgICBidWls
dGluICYgKG5ldyBpbiA1LjE4KSBtYWNoaW5lDQo+ICAgLmltYSAgICAgICAgICAgICAgICAgICAg
aW1hICAgICAgICAgIGJ1aWx0aW4gJiBzZWNvbmRhcnkNCj4gICAucGxhdGZvcm0gICAgICAgICAg
ICAgICBwbGF0Zm9ybSAgICAgZmlybXdhcmUsIFNCLCBNT0sNCj4gICAubWFjaGluZSAgICAgICAg
ICAgICAgICBtYWNoaW5lICAgICAgTU9LLCBtYW5hZ2VtZW50IHN5c3RlbQ0KPiAgICAgIA0KPiBJ
biBzaW1wbGlmaWVkIHN0b3J5IGZvcm0sIGhhcmR3YXJlIGtleXMgYXV0aG9yaXplIHNlY3VyZSBi
b290IGtleXMsDQo+IHdoaWNoIGF1dGhvcml6ZSB0aGUgYm9vdGxvYWRlciwgd2hpY2ggYXV0aG9y
aXplcyB3aG9ldmVyIHNpZ25zDQo+IHRoZSBrZXJuZWwsIHdobyBhdXRob3JpemVzIHRoZSBidWls
dGluIGtleXMsIHdoaWNoIChhbG9uZyB3aXRoDQo+IHRoZSBtYWNoaW5lIGtleXMpIGF1dGhvcml6
ZSB0aGUgc2Vjb25kYXJ5IGtleXMsIHdoaWNoDQo+IChhbG9uZyB3aXRoIGJ1aWx0aW4pIGF1dGhv
cml6ZSB0aGUgaW1hIGtleXMuDQo+IA0KPiBUaGUgZmlybXdhcmUsIHNlY3VyZSBib290IGtleXMs
IG9yIG1hY2hpbmUgb3duZXIga2V5cyAoTU9LKQ0KPiBhdXRob3JpemUgdGhlIHBsYXRmb3JtIGtl
eXMuIE1PSyBvciBhIG1hbmFnZW1lbnQgc3lzdGVtDQo+IGF1dGhvcml6ZXMgdGhlIG1hY2hpbmUg
a2V5cy4NCj4gDQo+IEtleSB1c2FnZSBhbmQgcmVzdHJpY3Rpb25zDQo+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+IEluIGFkZGl0aW9uIHRvIGhhdmluZyBkaWZmZXJlbnQgb3JpZ2lucyBv
ZiB0cnVzdCwga2V5cyBhcmUgdXNlZA0KPiBmb3IgZGlmZmVyZW50IHB1cnBvc2VzOiB2ZXJpZnlp
bmcgc2lnbmF0dXJlcyBvbiBrZXJuZWwgbW9kdWxlcw0KPiAoY29kZSksIG9uIGtleGVjJ2Qga2Vy
bmVsIGltYWdlcyAoY29kZSksIG9uIGRhdGEsIGFuZCBvbiBvdGhlcg0KPiBrZXlzLiBTZWUgWzFd
IGZvciBtb3JlIGRldGFpbHMuIA0KPiANCj4gVW5mb3J0dW5hdGVseSwga2V5IHVzYWdlIHJlc3Ry
aWN0aW9ucyBhcmUgbm90IGNvbnNpc3RlbnRseQ0KPiBlbmZvcmNlZCB0aHJvdWdob3V0IHRoZSBr
ZXJuZWwuIEZvciBleGFtcGxlLCBhIGtleSB1c2VkIHRvDQo+IHZlcmlmeSBjb2RlIG1pZ2h0IGJl
IHVzZWQgdG8gdmVyaWZ5IGRhdGEgb3Igb3RoZXIga2V5cy4gDQo+IA0KPiBJbnN1ZmZpY2llbnQg
ZnVuY3Rpb25hbGl0eQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBCZWZvcmUgdGhl
IGFkZGl0aW9uIG9mIHRoZSBtYWNoaW5lIGtleXJpbmcsIHNlY29uZGFyeSBrZXlzDQo+IHdlcmUg
b25seSBhdXRob3JpemVkIGJ5IGJ1aWx0aW4gYW5kIG90aGVyIHNlY29uZGFyeSBrZXlzLg0KPiBU
aGVyZSB3YXMgYSB3ZWxsLWRlZmluZWQsIGJ1dCBpbmZsZXhpYmxlIHNvdXJjZSBvZiB0cnVzdC4N
Cj4gTXVsdGlwbGUgZGlzdHJvcyBuZWVkZWQgYSB3YXkgdG8gbG9hZCBrZXlzIGZyb20gc291cmNl
cw0KPiB1bmtub3duIGF0IGtlcm5lbCBzaWduaW5nIHRpbWUuIFRoZXkgdXNlZCB0aGVpciBvd24N
Cj4gb3V0LW9mLXRyZWUgcGF0Y2hlcyB0byBsb2FkIGFkZGl0aW9uYWwga2V5cyBvbnRvIHRoZQ0K
PiBzZWNvbmRhcnkga2V5cmluZy4gIA0KPiANCj4gVG9kYXksIHRoZSBvbmx5IHdheSB0byAqZ3Vh
cmFudGVlKiBwcm9wZXIgZW5mb3JjZW1lbnQgb2Yga2V5DQo+IHVzYWdlIGFuZCByZXN0cmljdGlv
bnMgaXMgdG8gY3JlYXRlIGEgbmV3IGtleXJpbmcgYW5kIHdyaXRlDQo+IHBhdGNoZXMgdG8gbGlt
aXQgaXRzIGZ1bmN0aW9uYWxpdHkuICBUaGUgcGxhdGZvcm0ga2V5cmluZywNCj4gdXNlZCBvbmx5
IGZvciB2ZXJpZnlpbmcga2V4ZWMnZCBrZXJuZWxzLCBpcyBhIGdvb2QgZXhhbXBsZS4NCj4gRXZl
biB0aGVuLCBjdXJyZW50IG5lZWRzIGFyZSBub3QgbWV0LiBGb3IgZXhhbXBsZSwgb25lIHZlbmRv
cg0KPiB3YW50cyB0byBwcm92aWRlIGFkZGl0aW9uYWwgZ3VpZGFuY2Ugc3VjaCBhcywgIlVzZSBr
ZXkgWDENCj4gb25seSBmb3IgdmVyaWZ5aW5nIGtlcm5lbCBtb2R1bGVzIGZyb20gdmVuZG9yIFgu
IiBPdGhlcnMgd2FudA0KPiB0byByZXN0cmljdCBrZXlzIHRvIHRob3NlIGxpbmtlZCB0byBhIGhh
cmR3YXJlIHJvb3Qgb2YgdHJ1c3QuDQo+IA0KPiBBZGRpdGlvbmFsIHByb2JsZW0NCj4gLS0tLS0t
LS0tLS0tLS0tLS0tDQo+IFdpdGggdGhlIGFkZGl0aW9uIG9mIHRoZSBtYWNoaW5lIGtleXJpbmcs
IGtleXMgZnJvbSBhIG5ldw0KPiBzb3VyY2Ugb2YgdHJ1c3QgY2FuIGJlIGFkZGVkIHRvIHRoZSBz
ZWNvbmRhcnkga2V5cmluZy4NCj4gV2l0aG91dCBwcm9wZXIgZW5mb3JjZW1lbnQgb2Yga2V5IHVz
YWdlIGFuZCByZXN0cmljdGlvbnMsDQo+IHRob3NlIGtleXMgY2FuIGJlIHVzZWQgZm9yIGFueSBw
dXJwb3NlLg0KPiANCj4gDQo+IFByb3Bvc2VkIHNvbHV0aW9ucw0KPiAtLS0tLS0tLS0tLS0tLS0t
LS0NCj4gMS4gSW4gdGhlIHNob3J0IHRlcm0sIGxvYWQgb25seSBDQSBrZXlzIG9udG8gdGhlIG1h
Y2hpbmUga2V5cmluZw0KPiAgICBhbmQgcmUtZW5hYmxlIElNQS4gRGVmaW5lIGEga2VybmVsIGNv
bmZpZ3VyYXRpb24gb3B0aW9uIHRvIHByZXZlbnQNCj4gICAgYnJlYWthZ2UuICBUaGUga2VybmVs
IGNvbmZpZ3VyYXRpb24gb3B0aW9uIGNvdWxkIGVpdGhlciBlbmFibGUgb3INCj4gICAgZGlzYWJs
ZSBDQS1vbmx5IGtleXMuDQoNCkFzIHlvdSBhcmUgYXdhcmUsIHByaW9yIHRvIHRoZSBpbnRyb2R1
Y3Rpb24gb2YgdGhlIG1hY2hpbmUga2V5cmluZywgDQptb3N0IGRpc3Ryb3Mgc2ltcGx5IGFsbG93
ZWQgYWxsIGtleXMgY29udGFpbmVkIHdpdGhpbiB0aGUgcGxhdGZvcm0gDQprZXlyaW5nIHRvIGJl
IHVzZWQgZm9yIGJvdGgga2VybmVsIGFuZCBtb2R1bGUgdmVyaWZpY2F0aW9uLiAgVGhpcyB3YXMg
DQpkb25lIGJ5IGFuIG91dCBvZiB0cmVlIHBhdGNoLiAgU29tZSBkaXN0cm9zIHRvb2sgaXQgZXZl
biBmdXJ0aGVyIGFuZCBsb2FkZWQgDQphbGwgdGhlc2Uga2V5cyBpbnRvIHRoZSBzZWNvbmRhcnkg
dHJ1c3RlZCBrZXlyaW5nLiAgVGhpcyBhbGxvd2VkIHRoZSBzeXN0ZW0gDQpvd25lciB0byBhZGQg
dGhlaXIgb3duIElNQSBDQSB0aHJvdWdoIHRoZSBNT0suDQoNCkVhY2ggZGlzdHJvIGNvbnRhaW5z
IHNpbWlsYXIgZG9jdW1lbnRhdGlvbiBvbiBob3cgdG8gc2lnbiBrZXJuZWwgbW9kdWxlcyANCmFu
ZCBlbnJvbGwgdGhlIGtleSBpbnRvIHRoZSBNT0suICBUaGUgcHJvY2VzcyBpcyBmYWlybHkgc3Ry
YWlnaHRmb3J3YXJkLiAgDQpXaXRoIHRoZSBpbnRyb2R1Y3Rpb24gb2YgdGhlIG1hY2hpbmUga2V5
cmluZywgdGhlIHByb2Nlc3MgcmVtYWlucyBiYXNpY2FsbHkgDQp0aGUgc2FtZSwgd2l0aG91dCB0
aGUgbmVlZCBmb3IgYW55IG91dCBvZiB0cmVlIHBhdGNoZXMuDQoNCk15IGNvbmNlcm4gaW4gb25s
eSBhbGxvd2luZyBDQSBrZXlzIGludG8gdGhlIG1hY2hpbmUga2V5cmluZyBpcyBkaXN0cm9zIHdp
bGwgDQp2aWV3IHRoaXMgYXMgYSByZWdyZXNzaW9uIGFuZCBnbyBiYWNrIHRvIGhhdmluZyB0byBj
YXJyeSBhbm90aGVyIG91dCBvZiB0cmVlIA0KcGF0Y2hzZXQuICBJdCB3aWxsIGJyZWFrIHdoYXQg
aGFzIHdvcmtlZCBpbiB0aGVpciBkaXN0cm8gZm9yIHllYXJzLiAgQ0Ega2V5cyANCmhhdmUgbmV2
ZXIgYmVlbiBuZWNlc3NhcnkgZm9yIHNpZ25pbmcgYSBrZXkgdXNlZCAgdG8gc2lnbiB0aGVpciBr
ZXJuZWwgDQptb2R1bGUuIFRoZSBlbmQtdXNlciB3aWxsIG5vdyBuZWVkIHRvIGVucm9sbCB0d28g
a2V5cy4gIEZpcnN0IHRoZSBDQQ0KS2V5IGludG8gdGhlIE1PSyBhbmQgdGhlbiB0aGUgbGVhZiBj
ZXJ0IGludG8gdGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcuDQoNCj4gMi4gRG9uJ3QgbGlu
ayB0aGUgbWFjaGluZSBrZXlyaW5nIHRvIHRoZSBzZWNvbmRhcnkga2V5cmluZy4NCj4gICAgSnVz
dCBhcyB0aGVyZSBhcmUgbGltaXRhdGlvbnMgb24gdXNhZ2Ugb2Yga2V5cyBpbiBwbGF0Zm9ybSwN
Cj4gICAgYWRkIGxpbWl0YXRpb25zIG9uIGtleXMgaW4gbWFjaGluZSB0byBhIHZlcnkgc3BlY2lm
aWMgc3RhdGVkDQo+ICAgIHB1cnBvc2UsIGNsZWFybHkgZXhwcmVzc2VkIGluIHRoZSBjb3ZlciBs
ZXR0ZXIgYW5kIHBhdGNoDQo+ICAgIGRlc2NyaXB0aW9uLCBlLmcuLCB2ZXJpZnlpbmcga2VybmVs
IG1vZHVsZXMuDQo+IDMuIEluIHRoZSBsb25nIHRlcm0sIHdvcmsgdG93YXJkcw0KPiAgICBhKSBl
bmZvcmNlbWVudCBvZiBrZXkgdXNhZ2UgaW4gdGhlIGNlcnRpZmljYXRlLCBhbmQNCg0KVGhpcyBp
cyB0aGUgcGF0aCBJIHN0YXJ0ZWQgZG93biB3aXRoIHRoaXMgc2VyaWVzIFsxXS4gDQoNCkl0IGNv
bnRpbnVlcyB0byBsb2FkIGFsbCBrZXJuZWwgY29tcGlsZWQtaW4ga2V5cyBpbnRvIHRoZSBidWls
dGluIGtleXJpbmcgDQoodGhlc2Uga2V5cyBtYXkgb3IgbWF5IG5vdCBiZSBhIENBKS4gIEl0IGFs
c28gY29udGludWVzIHRvIGxvYWQgYWxsIE1PSyANCmtleXMgaW50byB0aGUgbWFjaGluZSBrZXly
aW5nIChhZ2FpbiwgdGhlc2Uga2V5cyBtYXkgb3IgbWF5IG5vdCBiZSBhIA0KQ0EpLiAgSXQgdHJl
YXRzIHRoZXNlIGtleXMgZXF1YWxseSwgaW5kZXBlbmRlbnQgZnJvbSB0aGVpciBvcmlnaW5hbCBz
b3VyY2UuICANCkJvdGggYnVpbHRpbiBhbmQgbWFjaGluZSBrZXlzIGFyZSBwYXJzZWQgdG8gc2Vl
IGlmIGtleUNlcnRTaWduIGlzIHNldC4gIA0KVGhlIENBIGZsYWcgaXMgY2hlY2tlZCBhbmQgdGhl
IGtleSBpcyB2YWxpZGF0ZWQgdG8gYmUgcHJvcGVybHkgc2VsZiBzaWduZWQuICANCklmIGFsbCB0
aGVzZSBjb25kaXRpb25zIGFyZSBtZXQsIGEgbmV3IFJPVCBmbGFnIGlzIHNldC4gIEkga25vdyBN
aW1pIGRpZG7igJl0IA0KbGlrZSB0aGUgbmFtaW5nIG9mIHRoaXMgZmxhZy4gIFdpdGggYW55IFgu
NTA5IGNlcnQsIG1vc3Qgb2YgdGhlIGluZm9ybWF0aW9uIGlzIA0KdGhyb3duIGF3YXkgaW4gdGhl
IGtlcm5lbCBhZnRlciBpdCBpcyBwYXJzZWQuIFZlcnkgZmV3IHBpZWNlcyBvZiB0aGUgY2VydGlm
aWNhdGUgDQphcmUgbGVmdCBpbiB0YWN0IGFmdGVyIHRoZXkgYXJlIGxvYWRlZCBpbnRvIGEga2V5
cmluZy4gIFRoYXQgaXMgd2h5IHRoaXMgbmV3IGZsYWcgDQp3YXMgaW50cm9kdWNlZC4gSSB0cmll
ZCB0byBjb21lIHVwIHdpdGggYSB0ZXJtIHRoYXQgd2FzIGdlbmVyaWMgZW5vdWdoIHRvIGJlIA0K
dXNlZCBieSBhbGwgdHlwZXMgb2YgcHVibGljIGtleXMgYW5kIG5vdCBiZSBYLjUwOSBzcGVjaWZp
Yy4gIFRoZSBmbGFnIG1heSBhbHNvIA0KYmUgc2V0IGlmIGEgcHJvcGVybHkgZGVmaW5lZCBpbnRl
cm1lZGlhdGUgQ0EgaXMgZm91bmQuICANCg0KQWZ0ZXJ3YXJkcyBhIG5ldyBsaW5rIHJlc3RyaWN0
aW9uIGlzIGludHJvZHVjZWQuICBUaGUgZmlyc3Qga2V5cmluZyB0byB1c2UgdGhpcyANCnJlc3Ry
aWN0aW9uIGlzIHRoZSBJTUEga2V5cmluZy4gIEtleXMgYWRkZWQgdG8gdGhlIElNQSBrZXlyaW5n
IG11c3QgcGFzcyB0aGUgDQpuZXcgcmVzdHJpY3Rpb24gdGVzdCB3aGljaCB2YWxpZGF0ZXMgdGhl
IGxlYWYgY2VydCBjYW4gYmUgdm91Y2hlZCBmb3IgYnkgYW55IA0Ka2V5IGNvbnRhaW5pbmcgdGhl
IG5ldyBST1QgZmxhZy4NCg0KSWYgdGhpcyBhcHByb2FjaCBpcyB0byBiZSBjb250aW51ZWQsIEni
gJltIGNlcnRhaW5seSBvcGVuIHRvIHJlbmFtaW5nIHRoZSBmbGFnLiAgT3RoZXIgDQpmbGFncyBj
b3VsZCBhbHNvIGJlIGFkZGVkLCBmb3IgZXhhbXBsZSBpZiB0aGUgdXNhZ2UgaXMgZGlnaXRhbFNp
Z25hdHVyZSwgdGhpcyBjb3VsZCANCmJlIGVuZm9yY2VkIGFzIHdlbGwuIEJ5IGFkZGluZyB0aGVz
ZSBmbGFncywgaXQgZG9lc27igJl0IGJyZWFrIGV4aXN0aW5nIGNvZGUgaW4gdGhlIA0Ka2VybmVs
LiAgVGhlIHB1YmxpYyBrZXkgZG9lc27igJl0IG5lZWQgdG8gYmUgY2hhbmdlZCB0byBrZWVwIGEg
bGFyZ2UgcXVhbnRpdHkgb2YgDQpYLjUwOSBzcGVjaWZpYyBkYXRhLiAgSXQgYWxzbyBhbGxvd3Mg
a2V5IHVzYWdlIHRvIGJlIHNsb3dseSBpbnRyb2R1Y2VkIGludG8gdGhlIA0Ka2VybmVsIHdpdGhv
dXQgYnJlYWtpbmcgZXhpc3RpbmcgZGlzdHJvcy4gDQoNCkkgd291bGQgbGlrZSB0byBrbm93IGlm
IGFuIGFwcHJvYWNoIHNpbWlsYXIgdG8gdGhpcyB3b3VsZCBiZSBjb25zaWRlcmVkLiAgDQoNClsx
XSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qva2V5cmluZ3MvY292ZXIvMjAy
MjA0MDYwMTUzMzcuNDAwMDczOS0xLWVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbS8jMjQ4MDg4MzEN
Cg0K
