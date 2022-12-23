Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF397655394
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Dec 2022 19:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiLWSSb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Dec 2022 13:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiLWSSa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Dec 2022 13:18:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2751EC46;
        Fri, 23 Dec 2022 10:18:28 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNEEFS5011709;
        Fri, 23 Dec 2022 18:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YmVR9RrHOZ3CpgXU5lNIQPyfKaqPQzqQsoHmvu7wolE=;
 b=kso0HHaqHGqynU7ZyYee1guBJtuk31gMsGdgTc/LxMrtAXSzpmCUIxW7GsuWpfvl8ByG
 eMh37C5VH6G9hRqpsRLxHIMLqO2vRCdqmztj9kHAwQ0Z0sIulx51T/0bs++iOPMfSsB1
 6S53uiz/hDR3SEt/5soDXPo6HKdQPvvuYj22Bw7Sgyj2OTR439F1/8Y5Y2YaGLT+jHGc
 PotbReesB5YBFXLg0vNXOPP3nboJMO9USq+Sw+QHs5lhGN8GYoaz2zgW0MmWhkC4edXz
 mED5rJ+FSqy7qldX+EXsXWfo+iSiFwXQwjaVUCmkYsTMnv+sJN6DVMfuf1La1bnzjzL4 gQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tn6cxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Dec 2022 18:17:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BNHhs9t020476;
        Fri, 23 Dec 2022 18:17:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh479habu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Dec 2022 18:17:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1ksk7ZfFHgnGWqADhjYgi/e2tMlIsb/w3B3sfzL/BqRgfzApk/9WPxouY1haNMdFpWOdQsqzlPAbEcIfdA0blely8nrQbCMWX41209VGrkCqZfbO5QOnituVqwWp3viYxX5xVcN8DTrIACfzEJJ3mI8/eAGvVNanMDPHXjqQCctWL93Jcg7+t5e/j9rA9zYmuo+eRaYjzBvjwOPD+m5CHAOiOwQMwTftungyDN7VtFhN0UP+qUvl2UwH0JDYtrJW/xVjGDA6YTzMPnETXzP9k0Lp34QnrfEiZFlFWPGB4OyNyFe5C7jNe3lQI6v9s01r/95y2DS3VdpQQMbNQDswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmVR9RrHOZ3CpgXU5lNIQPyfKaqPQzqQsoHmvu7wolE=;
 b=c8ZPp61D+g0oTUQeYjMfcEDuHE6iHfUkA+s1C4Jov5yxeoMF0vImBfnc+eXLmI6QHKxjneEXEi9gaFZh1rEX6K8Q0Y1ouLEKAWrTfOm70vmZDFd66V5KFYUVxIi+E7y4U7SaaNDeugXolqPZ+6NZwdezIN1P+aVh7B3sZyQxhxNoXM+09lUhEkCznjU6VK3t3jM7wgO6XMZ2qr1G68CAIoW5FbhugJGZ2M2pdL6gg9iHx0WQiDF8LgpQMzbaFonebcOb9qZemyYaHLqbmEqCRXQ9j+pgaj/XwpV+VspX1v2hde+Lz9C1u1ldjPls/QgeugPmVBZ83VlveohUlZxrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmVR9RrHOZ3CpgXU5lNIQPyfKaqPQzqQsoHmvu7wolE=;
 b=k8kyI4SaCY3tLEGuREXlRDnS3drsUqbXZyvQVf+on1Fqf5KkT5acuLu0D7kVThi21jrpBceTjnbOCATHyFygEG8YNhgCjuMPl+8JoPQ2jppOorP4QGd9LcTC2bq1O9PNHW6Yd+JSWLvRwPBk8EgbSMHRCxHuRNjFKZ4iRmHzegg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 23 Dec
 2022 18:17:47 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 18:17:47 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>, Coiby Xu <coxu@redhat.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Index: AQHZD1PCFegbrli1zUCp/3TmJTzIr65uvzMAgABmOoCAADsnAIAACGGAgAAJu4CAAAvJAIABEiUAgAMHQoCABR0rgIAACaUAgAFTMgCAAAcpgIABm1+AgAAFzwCAABzUgA==
Date:   Fri, 23 Dec 2022 18:17:47 +0000
Message-ID: <61C653C2-A972-40DB-9738-B418A1C601FC@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
 <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
 <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
 <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
 <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
 <21E52C3E-0778-4908-AF44-F65D57BEC4E0@oracle.com>
 <20221216140648.h32gn5qf3igorpzi@Rk>
 <2d75dfd105f8558ecd1074d64e4252ddd63b698b.camel@linux.ibm.com>
 <0DAFCFC7-29EB-4481-8FF7-616336383378@oracle.com>
 <0fb737ab42ef093f7031a80c8a73f582b1d5c1ae.camel@linux.ibm.com>
 <6AAEC343-E581-4355-ABD8-FE32A1BD16D8@oracle.com>
 <4ac6b5bd1b57bfc0c548e5711e46b341fd5cfe39.camel@linux.ibm.com>
 <D1BF8D7B-F9E4-4C87-9288-534F3AE38ECF@oracle.com>
 <c2b4054c32a24e83186a953ef6e1e3e85aec603b.camel@linux.ibm.com>
In-Reply-To: <c2b4054c32a24e83186a953ef6e1e3e85aec603b.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|BLAPR10MB5108:EE_
x-ms-office365-filtering-correlation-id: fb863a08-eb71-4584-6b70-08dae511fe8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A2ntXuNMQaJUrCFpwxr2fW7ngSW2+jSJokPVi0JcHhYx5vcjTzUlYQ6SZa+082c97HV/W+fsgSA9uP3HIFwaQRlLW4l1Fphq0U6PhIfDabk6cgxJu2hmmMYQFSQvQ514dD4dd2zjcI2atYCulWyu7nYkBdH8JfFHUc+Zj2hpjVbv6b4qvQZTClys7uAL/l60TWcnYP5FnzXufQFcpo/skYELAaT4a5SEvyg0LpWxMRTywJ5MVfp1V21I9RcIAP6b0/+2fci82jHhF2UdII2l96p7g+Vw12Sb5XNrs35FZQKMvrZWBx+CFiDiqcVfpTdn7STY+nYVxFtbPEpN2+NkxB63MxkNowybwI/z9p53XQHsVt3C4ubzAilOE1aAjlsc1qUHXrm0F3GFTWTNjhxAnmtpfrX01ptbAmQ/GjnGmIrdJldW6RSu4KuhR/VKrxc4asaYVqTqhqYb/LKas5f7RnUYCc8KBQwj2Qhcmys01VRqKrYD7+LyrQuYP4wvG0wWLkhqL4/UZDiT8DoQlF25IzQ3wJCotDmTOXSH8BiC6pC03EE0zfqmrKUQHsM9es/3ibw7Z1UafANW73QVownrJd+PJkeHuzicwIlRABEp957GYVDKFXx3aN8Fi0qEDcvTfNcGz6LMn4Fb7vXkA7jpAuGo+FKCKMG7rrPI8zqhjy4N4n7Ji2ESxqCFqFSZw8lLMRX2zinZefs4L3w3c4E/tPJEvsA4CPYZ0zgRgA5oXuc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(71200400001)(186003)(6512007)(26005)(316002)(86362001)(2616005)(478600001)(6486002)(6506007)(53546011)(6916009)(54906003)(91956017)(44832011)(83380400001)(66574015)(33656002)(7416002)(5660300002)(76116006)(8676002)(4326008)(66556008)(66476007)(66446008)(64756008)(8936002)(41300700001)(66946007)(66899015)(4001150100001)(36756003)(2906002)(122000001)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUF4V2xFTUV2Ylk0eHd1SWd5RXpxTUR3ZmI1RjQrNGdKVnVHOUc4M1Rod003?=
 =?utf-8?B?MlZBdm9remh6elBlYVhxTmJ3dlhyeHJiN3MzNmQrbldqUEkyZ2txT01zekps?=
 =?utf-8?B?TUpVRjJ5OFhUTFRsc2kxNXRtWWtGQjU2czJ5TFdyZzluWW00SndyYXk2dVpU?=
 =?utf-8?B?WDRVd0VkckRsT0JzSkZSNDlLSjBwRjVRc0pMSHdnS1dSKzNwRVpINThaMnY3?=
 =?utf-8?B?alcvOWlOd2FNRndycUV3OFpjSjZqcHk0RWZFbnJOcVJwRUJxOG84aXFvTVBv?=
 =?utf-8?B?cjM0RWhhQ1BoY3pUcFUzNHVqL1hhT0VSS0VrWU1CUDg1dXR6YzdmcExQcS8x?=
 =?utf-8?B?MWNDRWFNcEZoVE9SbER1T2oyWGRSTGN6VWhWZlhaUU5CQ3hHTk1BVElNeUY1?=
 =?utf-8?B?bFhGckdYSFprekMvS0RqODRsVVRjbXpVdWpyV3k0TmV2Nkp3QlNBaVo0YW1u?=
 =?utf-8?B?TlVIRnBHWmFxZ3V4OWdWWXVzM292eHRDeXg0NVRQMXgvZERMUXZXT1F6Nmtx?=
 =?utf-8?B?d0o1NkY1NTNLMysvbkRlVytlejVqbXZrZ0pyd0dHNnNGb2Z5Zkh5M2FoWUVX?=
 =?utf-8?B?eXVRd2VFTGg2TmRoMXBWWnlpd3NRRlhXRnlNQ1lFd3JiVXZHNXZPQWN3SjBW?=
 =?utf-8?B?OGdFbm1nNW9zZ2UvaW91Z2kweXNHNmdUUDRaRXlkZHZmRURKeGI0cVl2UVVY?=
 =?utf-8?B?QTIweW9sSlVCV3lRSXMwbGFSL2pKNzNoZlBaN3JsL3FOd0VEZlBENHlab1Y5?=
 =?utf-8?B?eEU2QXE2MmNadjFBR0hDLzA0WlhTVkNkMC9mU09GWmQwT0tKamR0RG1oZ2dq?=
 =?utf-8?B?SnlhK21rQ2lKVTllN1NwYkVWQy9zK0QyUjZpODlobjNtMEsyM04veWRRdmtD?=
 =?utf-8?B?TDM3RUdNaEY3aUVidWNhM1VJRVNpMWppZFZqV0dWcWkwZ3BtMUVKMll0RG9G?=
 =?utf-8?B?UFJ0Ull1SHkya2VqeGR3bllobEp2dmVacUcweEloaVNpdHlUeDlWZkUrMkJI?=
 =?utf-8?B?em9DTERhVTRkbDNDMGJVRURCbVIzRExkckdRR29qeVFnM2dLcUgyemkwRVBK?=
 =?utf-8?B?Q1dseW5KYkFKR1Z5WlBobWV2RHRhSWxCa2kvSW9Xamc1a2FHdTdXQnVXaVdj?=
 =?utf-8?B?eWsxUE4xNjhKSm1KbVc1TVM0RnErSnJxRHZlbUJzaTlJZmNwdWtuSzZBNmJq?=
 =?utf-8?B?VkdpRU93Tyt0Zm9VMzJZVmhZQ0VvR3UxQ1NGUXJmMFJiLzJmSERTRnVaNXMz?=
 =?utf-8?B?bjAycjdtekR3aGo0WTBJVmQ5ZFFSakZrM3RNa3U5Wk1aRFNnUklaZ2daRDdo?=
 =?utf-8?B?YzcyZ0gzRUlXa045aXhvZXBWT2IzNFVqaGl1RElZNzBkWGlSZnVrZURvVUN6?=
 =?utf-8?B?MC93YjRENGQvR1F6QUpkdmFDeDdlSW5KZitVcy8xZzJ2Y0xBOUFGTzV3TXNF?=
 =?utf-8?B?NVBReVluTEZtMWRDMXBJYXJmbGVOVjVLa081RW9JVDZCTDV3RlNjM2FabStN?=
 =?utf-8?B?TnJqRWJSaXBWNmlhL1dma2VtRElRbmF2NFhXMy8zMjdJZTBnWkJYZkZ6UzNi?=
 =?utf-8?B?dlZCdmtzY2tiS0pRMW5sU05FamNFcGwxUHo5QTB3M3M4bDRYYWN6cUZlY3Ew?=
 =?utf-8?B?Mkd2OTFYWllZYS90MHp3TmgrdzB4TGdoWVhMYmdISWpGVG9FRG5KdktDRVVs?=
 =?utf-8?B?UXIwMFI3Mk5SWGRlU1YyTmlta2RjbC9PVjlObWFaUzByQjdpVE5XSzhJZkN6?=
 =?utf-8?B?a29JYU8rZDV5TExVS0dtZEc2b0xxNUdHYWxvZTIyKzViYmx2Rm9tRFRsa2pN?=
 =?utf-8?B?SkRJSjd3dWI5SGM1Tk9QbkV3bmZmLzJNbkxDRWRrbG9uOE00aFV6MnFpcUVU?=
 =?utf-8?B?UEpaanhvemZrdVR5VTJKd3FSTUt4c0MvNmVGWkRZUHVlWTBKekpPajBHd3ZJ?=
 =?utf-8?B?QXdCL0hKZS9ibko3aEh6SGkzRUR3bVFXa0xUQ3VWRHF3Nm1sZzZSMi9teEp6?=
 =?utf-8?B?dm9BL0ZhRHNEaU1GMEs3cFhFQUc2emUxUmRvUzlhNTIrTXRqL0M0YjNEd2lM?=
 =?utf-8?B?eGt0bm1vNmthTEV0MEZiSE5FbHdKOWt0K2pqQlB1SUcvYnNKQURldTFvQ3Vj?=
 =?utf-8?B?aE1KUWFISkJlL3hvZjhqdU9rS085UDhKTUFSMkNkNkMrcGtXVVl1b0VLckht?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6922C9B56C74CB43800A53420F2A0EAF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb863a08-eb71-4584-6b70-08dae511fe8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 18:17:47.3944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exTFgAnMptG4QR8XY6U4oEkXVggG8ZSOOXkP8ogWdFN5H1LyBb6bBjwaPjfAlOa74OQPDaZ5dN38xc+SyEytZoeeC0YwCXVn4/+JX1Hg+6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_06,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230152
X-Proofpoint-ORIG-GUID: j9iJ0MyXNIaRgzsAczCkv3AFkB1dVekh
X-Proofpoint-GUID: j9iJ0MyXNIaRgzsAczCkv3AFkB1dVekh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gRGVjIDIzLCAyMDIyLCBhdCA5OjM0IEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAyMi0xMi0yMyBhdCAxNjoxMyArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIERlYyAyMiwgMjAyMiwgYXQgODo0
MSBBTSwgTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
T24gVGh1LCAyMDIyLTEyLTIyIGF0IDE1OjE1ICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0K
Pj4+PiANCj4+Pj4+IE9uIERlYyAyMSwgMjAyMiwgYXQgMTI6MDEgUE0sIE1pbWkgWm9oYXIgPHpv
aGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiBXZWQsIDIwMjItMTIt
MjEgYXQgMTg6MjcgKzAwMDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4+
IE9uIERlYyAxOCwgMjAyMiwgYXQgNToyMSBBTSwgTWltaSBab2hhciA8em9oYXJAbGludXguaWJt
LmNvbT4gd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBPbiBGcmksIDIwMjItMTItMTYgYXQgMjI6
MDYgKzA4MDAsIENvaWJ5IFh1IHdyb3RlOg0KPj4+Pj4+Pj4gSGkgRXJpYyBhbmQgTWltaSwNCj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4gT24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgMDk6NDU6MzdQTSArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+
Pj4+Pj4+PiBBIENBIGNlcnQgc2hhbGwgYmUgZGVmaW5lZCBhcyBhbnkgWDUwOSBjZXJ0aWZpY2F0
ZSB0aGF0IGNvbnRhaW5zIHRoZQ0KPj4+Pj4+Pj4+Pj4+Pj4+IGtleUNlcnRTaWduIGtleSB1c2Fn
ZSBhbmQgaGFzIHRoZSBDQSBiaXQgc2V0IHRvIHRydWUuDQo+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+
Pj4+Pj4+Pj4+IEhpIEVyaWMsDQo+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+IEFsbG93
aW5nIENBIGNlcnRpZmljYXRlcyB3aXRoIHRoZSBkaWdpdGFsU2lnbmF0dXJlIGtleSB1c2FnZSBm
bGFnDQo+Pj4+Pj4+Pj4+Pj4+PiBlbmFibGVkIGRlZmVhdHMgdGhlIHB1cnBvc2Ugb2YgdGhlIG5l
dyBLY29uZmlnLiAgUGxlYXNlIHVwZGF0ZSB0aGUNCj4+Pj4+Pj4+Pj4+Pj4+IGFib3ZlIGRlZmlu
aXRpb24gdG8gZXhjbHVkZSB0aGUgZGlnaXRhbFNpZ25hdHVyZSBrZXkgdXNhZ2UgZmxhZyBhbmQN
Cj4+Pj4+Pj4+Pj4+Pj4+IG1vZGlmeSB0aGUgY29kZSBhY2NvcmRpbmdseS4NCj4+Pj4+Pj4+Pj4+
Pj4gDQo+Pj4+Pj4+Pj4+Pj4+IFdpdGhpbiB2MiwgdGhlIHJlcXVlc3Qgd2FzIG1hZGUgdG8gYWxs
b3cgSW50ZXJtZWRpYXRlIENBIGNlcnRpZmljYXRlcyB0byBiZQ0KPj4+Pj4+Pj4+Pj4+PiBsb2Fk
ZWQgZGlyZWN0bHkuICBUaGUgSW50ZXJtZWRpYXRlIENBIHJlZmVyZW5jZWQgd2FzIHRoZSBvbmUg
dXNlZCBieSBrZXJuZWwub3JnLg0KPj4+Pj4+Pj4+Pj4+PiBUaGlzIEludGVybWVkaWF0ZSBDQSBj
b250YWlucyBib3RoIGRpZ2l0YWxTaWduYXR1cmUgYW5kIGtleUNlcnRTaWduLiAgSWYgdGhlIGNv
ZGUNCj4+Pj4+Pj4+Pj4+Pj4gaXMgY2hhbmdlZCB0byBleGNsdWRlIHRoaXMgY2VydGlmaWNhdGUs
IG5vdyB0aGUgcm9vdCBDQSBoYXMgdG8gYmUgbG9hZGVkIGFnYWluLiAgSXMgdGhhdA0KPj4+Pj4+
Pj4+Pj4+PiB0aGUgaW50ZW50Pw0KPj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+IFRoYXQgZGVm
aW5pdGVseSB3YXMgbm90IHRoZSBpbnRlbnQuICBOb3Igd291bGQgaXQgYWRkcmVzcyB0aGUgaXNz
dWUgb2YNCj4+Pj4+Pj4+Pj4+PiBhIHBhcnRpY3VsYXIgaW50ZXJtZWRpYXRlIENBIGNlcnRpZmlj
YXRlIGhhdmluZyBib3RoIGtleUNlcnRTaWduIGFuZA0KPj4+Pj4+Pj4+Pj4+IGRpZ2l0YWxTaWdu
YXR1cmUuDQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IFNvcnJ5LCBJ4oCZbSBub3QgZm9sbG93
aW5nLiAgV2h5IGlzIGl0IGFuIGlzc3VlIHRoYXQgYW4gaW50ZXJtZWRpYXRlIENBIGNlcnRpZmlj
YXRlIGNvbnRhaW5zDQo+Pj4+Pj4+Pj4+PiBib3RoIGtleUNlcnRTaWduIGFuZCBkaWdpdGFsU2ln
bmF0dXJlPyBXaHkgd291bGQgd2Ugd2FudCB0byBleGNsdWRlIGFuIEludGVybWVkaWF0ZQ0KPj4+
Pj4+Pj4+Pj4gQ0EgY2VydCBsaWtlIHRoZSBvbmUgdXNlZCBvbiBrZXJuZWwub3JnPw0KPj4+Pj4+
Pj4+PiANCj4+Pj4+Pj4+Pj4gSSBtdXN0IGJlIG1pc3Npbmcgc29tZXRoaW5nLiAgSXNuJ3QgdGhl
IHB1cnBvc2Ugb2YgImtleVVzYWdlIiB0bw0KPj4+Pj4+Pj4+PiBtaW5pbWl6ZSBob3cgYSBjZXJ0
aWZpY2F0ZSBtYXkgYmUgdXNlZD8gICBXaHkgd291bGQgd2Ugd2FudCB0aGUgc2FtZQ0KPj4+Pj4+
Pj4+PiBjZXJ0aWZpY2F0ZSB0byBiZSB1c2VkIGZvciBib3RoIGNlcnRpZmljYXRlIHNpZ25pbmcg
YW5kIGNvZGUgc2lnbmluZz8NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBFdmVyeSAzcmQgcGFydHkg
aW50ZXJtZWRpYXRlIENBIEkgaGF2ZSBsb29rZWQgYXQgc28gZmFyIGNvbnRhaW5zIGJvdGggc2V0
LiBNb3N0IGhhdmUgQ1JMU2lnbiBzZXQuDQo+Pj4+Pj4+Pj4gVHlwaWNhbGx5IHRoZSByb290IENB
IGNvbnRhaW5zIGtleUNlcnRTaWduIGFuZCBDUkxTaWduLCBidXQgc29tZSBhbHNvIGhhdmUgZGln
aXRhbFNpZ25hdHVyZQ0KPj4+Pj4+Pj4+IHNldC4gIEZpbmRpbmcgYSAzcmQgcGFydHkgSW50ZXJt
ZWRpYXRlIENBIHdpdGhvdXQgZGlnaXRhbFNpZ25hdHVyZSBzZXQgaXMgcHJvYmFibHkgZ29pbmcg
dG8gYmUNCj4+Pj4+Pj4+PiBjaGFsbGVuZ2luZyBhbmQgd2lsbCBzZXZlcmVseSBsaW1pdCB1c2Fn
ZS4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gSG93IGFib3V0IGFsbG93aW5nIGJvdGgga2V5Q2VydFNp
Z24gYW5kIGRpZ2l0YWxTaWduYXR1cmUgYXNzZXJ0ZWQgYnV0DQo+Pj4+Pj4+PiBpc3N1aW5nIGEg
d2FybmluZyBmb3IgdGhpcyBjYXNlPw0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBIZXJlJ3MgbXkgcmF0
aW9uYWxlIGZvciB0aGlzIHByb3Bvc2FsLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBJIGFzc3VtZSB3
ZSBzaG91bGQgY29uZm9ybSB0byBzb21lIFguNTA5IHNwZWNpZmljYXRpb25zLiBTbyBJIGNoZWNr
ZWQNCj4+Pj4+Pj4+ICJSRkMgNTI4MDogSW50ZXJuZXQgWC41MDkgUHVibGljIEtleSBJbmZyYXN0
cnVjdHVyZSBDZXJ0aWZpY2F0ZSBhbmQNCj4+Pj4+Pj4+IENlcnRpZmljYXRlIFJldm9jYXRpb24g
TGlzdCAoQ1JMKSBQcm9maWxlIiBbMV0gYW5kIElUVS1UIFguNTA5ICgyMDEyLTEwKQ0KPj4+Pj4+
Pj4gWzJdLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBbMV0gc3RhdGVzIGluIDQuMi4xLjMuIEtleSBV
c2FnZSwNCj4+Pj4+Pj4+ICJJZiB0aGUga2V5VXNhZ2UgZXh0ZW5zaW9uIGlzIHByZXNlbnQsIHRo
ZW4gdGhlIHN1YmplY3QgcHVibGljIGtleQ0KPj4+Pj4+Pj4gTVVTVCBOT1QgYmUgdXNlZCB0byB2
ZXJpZnkgc2lnbmF0dXJlcyBvbiBjZXJ0aWZpY2F0ZXMgb3IgQ1JMcyB1bmxlc3MNCj4+Pj4+Pj4+
IHRoZSBjb3JyZXNwb25kaW5nIGtleUNlcnRTaWduIG9yIGNSTFNpZ24gYml0IGlzIHNldC4gIElm
IHRoZSBzdWJqZWN0DQo+Pj4+Pj4+PiBwdWJsaWMga2V5IGlzIG9ubHkgdG8gYmUgdXNlZCBmb3Ig
dmVyaWZ5aW5nIHNpZ25hdHVyZXMgb24NCj4+Pj4+Pj4+IGNlcnRpZmljYXRlcyBhbmQvb3IgQ1JM
cywgdGhlbiB0aGUgZGlnaXRhbFNpZ25hdHVyZSBhbmQNCj4+Pj4+Pj4+IG5vblJlcHVkaWF0aW9u
IGJpdHMgU0hPVUxEIE5PVCBiZSBzZXQuICBIb3dldmVyLCB0aGUgZGlnaXRhbFNpZ25hdHVyZQ0K
Pj4+Pj4+Pj4gYW5kL29yIG5vblJlcHVkaWF0aW9uIGJpdHMgTUFZIGJlIHNldCBpbiBhZGRpdGlv
biB0byB0aGUga2V5Q2VydFNpZ24NCj4+Pj4+Pj4+IGFuZC9vciBjUkxTaWduIGJpdHMgaWYgdGhl
IHN1YmplY3QgcHVibGljIGtleSBpcyB0byBiZSB1c2VkIHRvIHZlcmlmeQ0KPj4+Pj4+Pj4gc2ln
bmF0dXJlcyBvbiBjZXJ0aWZpY2F0ZXMgYW5kL29yIENSTHMgYXMgd2VsbCBhcyBvdGhlciBvYmpl
Y3RzLiINCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gYW5kIFsyXSBzdGF0ZXMgaW4gOC4yLjIuMyBLZXkg
dXNhZ2UgZXh0ZW5zaW9uIHRoYXQsDQo+Pj4+Pj4+PiAiTW9yZSB0aGFuIG9uZSBiaXQgbWF5IGJl
IHNldCBpbiBhbiBpbnN0YW5jZSBvZiB0aGUga2V5VXNhZ2UgZXh0ZW5zaW9uLg0KPj4+Pj4+Pj4g
VGhlIHNldHRpbmcgb2YgbXVsdGlwbGUgYml0cyBzaGFsbCBub3QgY2hhbmdlIHRoZSBtZWFuaW5n
IG9mIGVhY2gNCj4+Pj4+Pj4+IGluZGl2aWR1YWwgYml0IGJ1dCBzaGFsbCBpbmRpY2F0ZSB0aGF0
IHRoZSBjZXJ0aWZpY2F0ZSBtYXkgYmUgdXNlZCBmb3INCj4+Pj4+Pj4+IGFsbCBvZiB0aGUgcHVy
cG9zZXMgaW5kaWNhdGVkIGJ5IHRoZSBzZXQgYml0cy4gVGhlcmUgbWF5IGJlIHJpc2tzDQo+Pj4+
Pj4+PiBpbmN1cnJlZCB3aGVuIHNldHRpbmcgbXVsdGlwbGUgYml0cy4gQSByZXZpZXcgb2YgdGhv
c2Ugcmlza3MgaXMNCj4+Pj4+Pj4+IGRvY3VtZW50ZWQgaW4gQW5uZXggSS4iDQo+Pj4+Pj4+PiAN
Cj4+Pj4+Pj4+IEkgaW50ZXJwcmV0IHRoZSBhYm92ZSB0ZXh0cyBhcyB3ZSBzaG91bGQgYWxsb3cg
Ym90aCBrZXlDZXJ0U2lnbiBhbmQNCj4+Pj4+Pj4+IGRpZ2l0YWxTaWduYXR1cmUuIEhvd2V2ZXIg
WzJdIHdhcm5zIGFib3V0IHRoZSByaXNrcyBvZiBzZXR0aW5nIG11bHRpcGxlDQo+Pj4+Pj4+PiBi
aXRzLiBRdW90aW5nIEFubmV4IEksDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+ICJDb21iaW5pbmcgdGhl
IGNvbnRlbnRDb21taXRtZW50IGJpdCBpbiB0aGUga2V5VXNhZ2UgY2VydGlmaWNhdGUNCj4+Pj4+
Pj4+IGV4dGVuc2lvbiB3aXRoIG90aGVyIGtleVVzYWdlIGJpdHMgbWF5IGhhdmUgc2VjdXJpdHkg
aW1wbGljYXRpb25zDQo+Pj4+Pj4+PiBkZXBlbmRpbmcgb24gdGhlIHNlY3VyaXR5IGVudmlyb25t
ZW50IGluIHdoaWNoIHRoZSBjZXJ0aWZpY2F0ZSBpcyB0byBiZQ0KPj4+Pj4+Pj4gdXNlZC4gSWYg
dGhlIHN1YmplY3QncyBlbnZpcm9ubWVudCBjYW4gYmUgZnVsbHkgY29udHJvbGxlZCBhbmQgdHJ1
c3RlZCwNCj4+Pj4+Pj4+IHRoZW4gdGhlcmUgYXJlIG5vIHNwZWNpZmljIHNlY3VyaXR5IGltcGxp
Y2F0aW9ucy4gRm9yIGV4YW1wbGUsIGluIGNhc2VzDQo+Pj4+Pj4+PiB3aGVyZSB0aGUgc3ViamVj
dCBpcyBmdWxseSBjb25maWRlbnQgYWJvdXQgZXhhY3RseSB3aGljaCBkYXRhIGlzIHNpZ25lZA0K
Pj4+Pj4+Pj4gb3IgY2FzZXMgd2hlcmUgdGhlIHN1YmplY3QgaXMgZnVsbHkgY29uZmlkZW50IGFi
b3V0IHRoZSBzZWN1cml0eQ0KPj4+Pj4+Pj4gY2hhcmFjdGVyaXN0aWNzIG9mIHRoZSBhdXRoZW50
aWNhdGlvbiBwcm90b2NvbCBiZWluZyB1c2VkLiBJZiB0aGUNCj4+Pj4+Pj4+IHN1YmplY3QncyBl
bnZpcm9ubWVudCBpcyBub3QgZnVsbHkgY29udHJvbGxlZCBvciBub3QgZnVsbHkgdHJ1c3RlZCwg
dGhlbg0KPj4+Pj4+Pj4gdW5pbnRlbnRpb25hbCBzaWduaW5nIG9mIGNvbW1pdG1lbnRzIGlzIHBv
c3NpYmxlLiBFeGFtcGxlcyBpbmNsdWRlIHRoZQ0KPj4+Pj4+Pj4gdXNlIG9mIGJhZGx5IGZvcm1l
ZCBhdXRoZW50aWNhdGlvbiBleGNoYW5nZXMgYW5kIHRoZSB1c2Ugb2YgYSByb2d1ZQ0KPj4+Pj4+
Pj4gc29mdHdhcmUgY29tcG9uZW50LiBJZiB1bnRydXN0ZWQgZW52aXJvbm1lbnRzIGFyZSB1c2Vk
IGJ5IGEgc3ViamVjdCwNCj4+Pj4+Pj4+IHRoZXNlIHNlY3VyaXR5IGltcGxpY2F0aW9ucyBjYW4g
YmUgbGltaXRlZCB0aHJvdWdoIHVzZSBvZiB0aGUgZm9sbG93aW5nDQo+Pj4+Pj4+PiBtZWFzdXJl
czogICANCj4+Pj4+Pj4+IOKAkyB0byBub3QgY29tYmluZSB0aGUgY29udGVudENvbW1pdG1lbnQg
a2V5IHVzYWdlIHNldHRpbmcgaW4NCj4+Pj4+Pj4+ICAgY2VydGlmaWNhdGVzIHdpdGggYW55IG90
aGVyIGtleSB1c2FnZSBzZXR0aW5nIGFuZCB0byB1c2UgdGhlDQo+Pj4+Pj4+PiAgIGNvcnJlc3Bv
bmRpbmcgcHJpdmF0ZSBrZXkgb25seSB3aXRoIHRoaXMgY2VydGlmaWNhdGU7ICAgDQo+Pj4+Pj4+
PiANCj4+Pj4+Pj4+IOKAkyB0byBsaW1pdCB0aGUgdXNlIG9mIHByaXZhdGUga2V5cyBhc3NvY2lh
dGVkIHdpdGggY2VydGlmaWNhdGVzIHRoYXQNCj4+Pj4+Pj4+ICAgaGF2ZSB0aGUgY29udGVudENv
bW1pdG1lbnQga2V5IHVzYWdlIGJpdCBzZXQsIHRvIGVudmlyb25tZW50cyB3aGljaA0KPj4+Pj4+
Pj4gICBhcmUgY29uc2lkZXJlZCBhZGVxdWF0ZWx5IGNvbnRyb2xsZWQgYW5kIHRydXN0d29ydGh5
Ig0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBTbyBtYXliZSBpdCdzIHVzZWZ1bCB0byBhZGQgYSB3YXJu
aW5nIGlmIGJvdGgga2V5Q2VydFNpZ24gYW5kDQo+Pj4+Pj4+PiBkaWdpdGFsU2lnbmF0dXJlIGFy
ZSBhc3NlcnRlZC4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IENvaWJ5LCB0aGFuayB5b3UgZm9yIGFkZGlu
ZyB0aGVzZSBkZXRhaWxzLiAgSSB3YXMgaG9waW5nIG90aGVycyB3b3VsZA0KPj4+Pj4+PiBjaGlt
ZSBpbiBhcyB3ZWxsLiAgSSBhZ3JlZSBhdCBtaW5pbXVtIHRoZXJlIHNob3VsZCBiZSBhIHdhcm5p
bmcuDQo+Pj4+Pj4gDQo+Pj4+Pj4gQSB3YXJuaW5nIGNvdWxkIGJlIGFkZGVkLg0KPj4+Pj4+IA0K
Pj4+Pj4+PiBQZXJoYXBzIGluc3RlYWQgb2YgbWFraW5nIElOVEVHUklUWV9DQV9NQUNISU5FX0tF
WVJJTkcgZGVwZW5kZW50IG9uDQo+Pj4+Pj4+IElOVEVHUklUWV9NQUNISU5FX0tFWVJJTkcsIG1h
a2UgdGhlbSBhIEtjb25maWcgImNob2ljZSIgdG8gc3VwcG9ydCB0aGUNCj4+Pj4+Pj4gbW9yZSBy
ZXN0cmljdGl2ZSBjZXJ0aWZpY2F0ZSB1c2UgY2FzZSByZXF1aXJlbWVudHM6ICBhbGwgY2VydGlm
aWNhdGVzLA0KPj4+Pj4+PiBDQSBjZXJ0aWZpY2F0ZSBzaWduaW5nIGFuZCBkaWdpdGFsIHNpZ25h
dHVyZSwgb25seSBDQSBjZXJ0aWZpY2F0ZQ0KPj4+Pj4+PiBzaWduaW5nLg0KPj4+Pj4+IA0KPj4+
Pj4+IEFzIGNvdWxkIHN1cHBvcnQgZm9yIGFkZGl0aW9uYWwgcmVzdHJpY3Rpb25zLg0KPj4+Pj4+
IA0KPj4+Pj4+IFdvdWxkIHRoZXNlIGFkZGl0aW9ucyBiZSByZXF1aXJlZCB3aXRoaW4gdGhpcyBz
ZXJpZXM/IFdoYXQgaXMgbWlzc2luZyBmcm9tIHRoaXMgDQo+Pj4+Pj4gZGlzY3Vzc2lvbiBpcyB3
aHkgd291bGQgdGhlc2UgYWRkaXRpb25zIGJlIG5lY2Vzc2FyeT8gIFdoeSBzaG91bGQgdGhlIGtl
cm5lbCANCj4+Pj4+PiBlbmZvcmNlIGEgcmVzdHJpY3Rpb24gdGhhdCBpcyBiZXlvbmQgdGhlIHNj
b3BlIG9mIHRoZSBYLjUwOSBzcGVjPyAgSWYgYSB3YXJuaW5nIHdhcyANCj4+Pj4+PiB0byBiZSBh
ZGRlZCwgd2hhdCB3b3VsZCBiZSB0aGUganVzdGlmaWNhdGlvbiBmb3IgYWRkaW5nIHRoaXMgYWRk
aXRpb25hbCBjb2RlPyAgRnJvbSANCj4+Pj4+PiBteSByZXNlYXJjaCBldmVyeSBzaW5nbGUgM3Jk
IHBhcnR5IGNvZGUgc2lnbmluZyBpbnRlcm1lZGlhdGUgQ0Egd291bGQgYmUgZmxhZ2dlZCANCj4+
Pj4+PiB3aXRoIHRoZSB3YXJuaW5nLiAgSXNu4oCZdCB0aGlzIGp1c3QgZ29pbmcgdG8gY2F1c2Ug
Y29uZnVzaW9uPyAgT3IgaXMgdGhlcmUgYSBiZW5lZml0IHRoYXQgDQo+Pj4+Pj4gSSBhbSBtaXNz
aW5nIHRoYXQgbmVlZHMgdG8gYmUgc3RhdGVkPw0KPj4+Pj4gDQo+Pj4+PiBZb3UncmUgZm9jdXNp
bmcgb24gdGhpcmQgcGFydHkga2VybmVsIG1vZHVsZXMgYW5kIGZvcmdldHRpbmcgYWJvdXQgdGhl
DQo+Pj4+PiBzaW1wbGUgdXNlIGNhc2Ugb2YgYWxsb3dpbmcgYW4gZW5kIHVzZXIgKG9yIGJ1c2lu
ZXNzKSB0byBzaWduIHRoZWlyIG93bg0KPj4+Pj4gY29kZS4gIFRydWUgdGhleSBjb3VsZCB1c2Ug
dGhlIGxlc3MgcmVzdHJpY3RpdmUgQ0EgY2VydGlmaWNhdGVzLCBidXQgaXQNCj4+Pj4+IGlzIHVu
bmVjZXNzYXJ5Lg0KPj4+PiANCj4+Pj4gTXkgZm9jdXMgaXMgb24gc2lnbmluZyB1c2VyLXNwYWNl
IGFwcGxpY2F0aW9ucywgYXMgb3V0bGluZWQgaW4gdGhlIGNvdmVyIGxldHRlci4gIFRoaXMgDQo+
Pj4+IHNlcmllcyBoYXMgbm90aGluZyB0byBkbyB3aXRoIGtlcm5lbCBtb2R1bGVzLiAgTW9zdCBl
bmQtdXNlcnMgYW5kIGJ1c2luZXNzZXMgcmVseSBvbiANCj4+Pj4gYSB0aGlyZCBwYXJ0eSB0byBk
ZWFsIHdpdGggY29kZSBzaWduaW5nLiAgQWxsIHRoaXJkIHBhcnR5IGNvZGUgc2lnbmluZyBzZXJ2
aWNlcyBJIGhhdmUgDQo+Pj4+IGZvdW5kIHVzZSBhbiBpbnRlcm1lZGlhdGUgQ0EgY29udGFpbmlu
ZyBtb3JlIHRoYW4ganVzdCB0aGUga2V5Q2VydFNpZ24gdXNhZ2Ugc2V0LiAgDQo+Pj4+IEl0IHNl
ZW1zIHRvIGJlIGFuIGluZHVzdHJ5IGFjY2VwdGVkIHByYWN0aWNlIHRoYXQgZG9lcyBub3Qgdmlv
bGF0ZSB0aGUgc3BlYy4gQmVmb3JlIHdyaXRpbmcNCj4+Pj4gbmV3IGNvZGUgdG8gZWl0aGVyIHdh
cm4gb3IgZXhjbHVkZSBhIHRoaXJkIHBhcnR5IGludGVybWVkaWF0ZSBDQSwgIEkgd291bGQgbGlr
ZSB0byB1bmRlcnN0YW5kIA0KPj4+PiB0aGUgbW90aXZhdGlvbiBiZWhpbmQgdGhpcyByZXF1ZXN0
Lg0KPj4+IA0KPj4+IEluIG9sZGVyIGRpc2N1c3Npb25zIHRoZXJlIGFyZSBjb21tZW50cyBsaWtl
LCAiQW55IENBIGNlcnRpZmljYXRlLCBubw0KPj4+IG1hdHRlciBpZiBpdCdzIGEgcm9vdCBvciBh
biBpbnRlcm1lZGlhdGUsIG11c3QgaGF2ZSB0aGUga2V5Q2VydFNpZ24NCj4+PiBleHRlbnNpb24u
IElmIHlvdSB3YW50IHRvIHNpZ24gYSByZXZvY2F0aW9uIGxpc3QgKENSTCkgd2l0aCB0aGUgQ0EN
Cj4+PiBjZXJ0aWZpY2F0ZSBhcyB3ZWxsICh5b3UgdXN1YWxseSBkbyB3YW50IHRoYXQpLCB0aGFu
IHlvdSBoYXZlIHRvIGFkZA0KPj4+IGNSTFNpZ24gYXMgd2VsbC4gQW55IG90aGVyIGtleVVzYWdl
cyBjYW4gYW5kIHNob3VsZCBiZSBhdm9pZGVkIGZvciBDQQ0KPj4+IGNlcnRpZmljYXRlcy4iDQo+
Pj4gDQo+Pj4gVGhlIHF1ZXN0aW9uIGFzIHRvICJ3aHkiIHRoaXMgY2hhbmdlZCB0byBpbmNsdWRl
ICJkaWdpdGFsU2lnbmF0dXJlIiB3YXMNCj4+PiBwb3NlZCBoZXJlIFsyXSB3aXRoIHRoZSByZXNw
b25zZSBiZWluZyBmb3IgIk9DU1AiLiAgIEl0IGFsc28gaW5jbHVkZXMgYQ0KPj4+IGxpbmsgdG8g
RW50cnVzdHMgcm9vdCBhbmQgaW50ZXJtZWRpYXRlIENBcyB3aXRoIGp1c3Qga2V5Q2VydFNpZ24g
YW5kDQo+Pj4gY1JMU2lnbiBrZXlVc2FnZXMuDQo+Pj4gDQo+Pj4gVGhlIG1hdGNoaW5lIGtleXJp
bmcgaXMgYSBtZWFucyBvZiBlc3RhYmxpc2hpbmcgYSBuZXcgcm9vdCBvZiB0cnVzdC4gDQo+Pj4g
VGhlIG1vdGl2YXRpb24gZm9yIGZ1cnRoZXIgcmVzdHJpY3RpbmcgQ0EgY2VydGlmaWNhdGVzIHRv
IGp1c3QNCj4+PiBrZXlDZXJ0U2lnbiBhbmQgY1JMU2lnbiBrZXlVc2FnZXMgaXMgdG8gbGltaXQg
aG93IHRoZSBDQSBjZXJ0aWZpY2F0ZXMNCj4+PiBtYXkgYmUgdXNlZC4gIFRoZXkgc2hvdWxkIG5v
dCBiZSB1c2VkIGZvciBjb2RlIHNpZ25pbmcuDQo+PiANCj4+IEZhaXIgZW5vdWdoLiAgSWYgdGhp
cyB3aWxsIGJlIHZpZXdlZCBhcyBqdXN0aWZpY2F0aW9uIGZvciBhZGRpbmcgdGhlIGFkZGl0aW9u
YWwgDQo+PiBjb2RlLCBJIGNhbiB3b3JrIG9uIGFkZGluZyBpdC4gIEFib3ZlIHlvdSBtZW50aW9u
ZWQgYSB3YXJuaW5nIHdvdWxkIGJlIG5lZWRlZCANCj4+IGF0IGEgbWluaW11bSBhbmQgYSByZXN0
cmljdGlvbiBjb3VsZCBiZSBwbGFjZWQgYmVoaW5kIGEgS2NvbmZpZy4gIEhvdyBhYm91dCBmb3Ig
DQo+PiB0aGUgZGVmYXVsdCBjYXNlIEkgYWRkIHRoZSB3YXJuaW5nIGFuZCB3aGVuIGNvbXBpbGlu
ZyB3aXRoIA0KPj4gSU5URUdSSVRZX0NBX01BQ0hJTkVfS0VZUklORyB0aGUgcmVzdHJpY3Rpb24g
d2lsbCBiZSBlbmZvcmNlZC4NCj4gDQo+IFNvdW5kcyBnb29kIHRvIG1lLiAgVG8gYXZvaWQgbWlz
dW5kZXJzdGFuZGluZ3MsIHdpbGwgdGhlcmUgYmUgYSBLY29uZmlnDQo+IG1lbnUgd2l0aCAzIG9w
dGlvbnM/ICANCg0KSSB3aWxsIGFkZCB0aGUgdGhyZWUgb3B0aW9ucyBpbiB0aGUgbmV4dCByb3Vu
ZC4NCg0KPiBUaGVyZSB3ZXJlIGEgY291cGxlIG9mIG90aGVyIGNvbW1lbnRzIGhhdmluZyB0bw0K
PiBkbyB3aXRoIHZhcmlhYmxlIG5hbWVzLiAgV2lsbCB5b3UgYWRkcmVzcyB0aGVtIGFzIHdlbGw/
DQoNCkFuZCB0YWtlIGNhcmUgb2YgdGhlIHZhcmlhYmxlIG5hbWUgY2hhbmdlcy4gIEkgd29u4oCZ
dCBnZXQgYmFjayB0byB0aGlzIHVudGlsIEphbnVhcnkuDQoNCg==
