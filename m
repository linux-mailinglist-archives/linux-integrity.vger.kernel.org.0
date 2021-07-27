Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C583D7CEF
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 19:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhG0R6k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 13:58:40 -0400
Received: from mail-eopbgr00113.outbound.protection.outlook.com ([40.107.0.113]:36068
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229593AbhG0R6k (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 13:58:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7eK4VZdu1ZxO8T/9r/MPyK4F4iGh/jB4JLWN61f/2FKxthBxQBoPFQafdoKu7e/OXGOrNjHYgOAdPBG5tZ8psyFqrQOhlOL5UeayP2rx8W306R7fGCEL13x3N7JQASUWIM+36HOH1tjMNhdGLFHsxqkXRVAryTL3FbgZA+JyJo2P+s2Hg09WB5G6ec26liscrY9eJAgPR6EnJudfz2R6zX6hraJuC9Sf9pHh7zhFVyJccCKC30RFzheC164fkXPQws+UtoR0s0JwhMemI1s8Ajeq+GqzuDt4LEEdMGID19duuWOMLags/X6mnpKXFERtVvp0cVmJ5tuHBTOs29jOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2Whjvxv+nNuypEPXa8QWzxc8RxusIQVA6TArOafyAA=;
 b=idjfLn133kA4I2GcS3p4BXQWpKDsSKjfowk/ep3BqatbjMX5yCXsTuPQZDv1KLeHMWEyWZnJ8lwn9RqplYQI1owUrQEtMv0U9628SfcuvoAP9yDDgdxExDF1VDTIM16iyKM/2EaksKIkcHLJIZ+WXBu34UGbDkrzUOlYqQyJAeNxcGU8ACexEPZkAa4kLPuar21N10e/XbOdGBljkhYB8SpRWDhHOEhLYiRCYKXOK5FGrYzxnExtmPKpuis1FF2OA6H9zmOgH4XV9z/+fvnY05tbuUYuQiAoiPfm0UwGHZHUqLWqqFNPTLLkWXUI4Ch5TsY4G3pF61AHfoxsA2uEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2Whjvxv+nNuypEPXa8QWzxc8RxusIQVA6TArOafyAA=;
 b=qpmtV5BhzPwvW4sxQbnfimCI51Pqn7+8MRjP3Byt9EBJ31a7vB0r+ayKBBpr66VS6klWlq9b49Qrb0UQydbO3JuwLf3ZRjaB9BIz80obeYonGcuZl/PgbtwUYFNE8ECw8WJOxd3m1BPcfKbgrFUBcyJJ47hYQjsi/ddcXY7sV3M=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4945.eurprd09.prod.outlook.com
 (2603:10a6:20b:305::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Tue, 27 Jul
 2021 17:58:38 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 17:58:38 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Subject: Re: [PATCH v4 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Topic: [PATCH v4 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Index: AQHXgwUlkMhVDaMJN0KxxpespO41cKtXErAAgAAJUYA=
Date:   Tue, 27 Jul 2021 17:58:38 +0000
Message-ID: <cb204a10-ed49-cfab-f15e-49a1425cec69@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
 <20210727163330.790010-6-simon.thoby@viveris.fr>
 <f042f5df077cdaf50688c7cc3fa8896491abf2bd.camel@linux.ibm.com>
In-Reply-To: <f042f5df077cdaf50688c7cc3fa8896491abf2bd.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 666af1d7-dcf9-4f1a-e7f0-08d951282942
x-ms-traffictypediagnostic: AM9PR09MB4945:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB4945CB74BF5E1A3B008D393A94E99@AM9PR09MB4945.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hjd2Q0f6CzAg2l0AV1QaqkOVqadoKac4QjlbJK4ivQGg/36YzYtslLNz5nwkyuS+gZ9IyQjkq5d262xwOAS3SizrSOE4xSXwR7/UEPPMwHS2ux3HARYuaKwWRmRNjQOwiZFFrNp13dkveRy5ibKDH8wHM2U81kRnxEh+Z7i1sQEb/Sf6jzI9G3BWEWFP72cr8hUhZUmcgE01LD/C0hqZinnwPEuiazDKXCkDasmTffyvdC9284lHVmy8KNjR9iKHsakRNcgMUETpPZjiklZLYnQfMdTTObcKnALZHAouimL95WfgYbjNo8G51UMeZAzqHLGwmrcIf5m12W2PUQfERcRmd7ofYreEVTuqulcdUgCmHzY8OrDHnqzSBm8k4vVheFs/dAxNtMnIcF7VeYtlETS33FJgo1O7yhRNyRPBUzH1zjUNPXuKngS2Ep5Qn78TuXfuQjCJjy7u6vemRr62PqNkQsLYJcJbA8w/5IFtquMot0OCRqO3x5YznygsWi77pfQYp13BewJBlU+mgqrkPCw1eNsE9LL3lVDgzfZVLdxpFYiM1FyKRscY9rF1hRFM14avd6kTQKSssJKEYw37eNjpu70kxSpjVFVXWtX3TEsScmw73EXxCx6PjqLuqG3fEVFcYxVNHjCpJtCXywoH2lhqJRwBGeG+meZ7J/ay2JYjXIGW7ZrbW3L3i6ul+hfIont+EL4K+Gf9Kyx7GSzgN/vWSm8u4Xg9kYLZ3Ilx8OaznKV5r+pnhyb37uGNCMNC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(366004)(5660300002)(36756003)(6506007)(53546011)(83380400001)(31686004)(316002)(66556008)(76116006)(110136005)(64756008)(66446008)(31696002)(6636002)(8676002)(86362001)(2616005)(66946007)(38100700002)(66476007)(91956017)(2906002)(6486002)(478600001)(122000001)(26005)(6512007)(186003)(8936002)(71200400001)(45980500001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?ewgE3SW+IVGaeD/o6CtpDwQtOkT9AD20aoMSaYMS8z29RNk1QA9nPOGV9?=
 =?iso-8859-15?Q?aG1lnAxvfNhNwsNYJItZAnO9MQclkazaFusu/o7UEYr2li2d2aVahhUHU?=
 =?iso-8859-15?Q?EEZtEioHE/8FeuI6ym1glw4Iwg+l1RIfIGJtooKfQA52PpcuSPc+tShme?=
 =?iso-8859-15?Q?BGTYKw81Y2oHd4ir+CRtjwiXixfnh5fTEv6+YkC96ZGQqe3ZWzAS8qHeQ?=
 =?iso-8859-15?Q?h5SjpJJAoDCXUf1fG2P5zmwRGpAnc+gk1fVr8py2whfch30NbdSCuZanM?=
 =?iso-8859-15?Q?8tOirgRoYpW/Vp42hGbi0zL/QdL04ZDxUvDUTRjachhEgGxQ8OsN0CgtQ?=
 =?iso-8859-15?Q?IuW38ZKEY+GSmCfcb6/Im3qeocDgaoCVVCCZB2gBZ/yRz7IX6KfqUX+5v?=
 =?iso-8859-15?Q?GJz8/MBQ4HmT80swmVnOXxTYmP5O6X1wpoF0Q3vWguhY6GomEVEWFpLU5?=
 =?iso-8859-15?Q?4l/v2uyYRuscOzJ5jBbetqP6z4QuQ7jfFveSmoo823oqemZGM4tEAa06F?=
 =?iso-8859-15?Q?5ApYN5ScXZc5O57DuspMC0swNXKPRvctIyHkQOKlm90EOttDnu1Q5Hjgj?=
 =?iso-8859-15?Q?c6pB/Unv87sNSjWcLdMt301JsrfGWbXyA1A+StmxrsaT3C/JbwJR8yI3o?=
 =?iso-8859-15?Q?qUqkjy6t4OlGjVOR7TntAjnjX1bl9y9WKxXdAxS7SIWAGXt7V40MU5UVx?=
 =?iso-8859-15?Q?Tu0acteIygJT2smg1Geci0/tSWSiOpqFgRVjfiWi//csq1bOawYNdNUes?=
 =?iso-8859-15?Q?NrHwWFOte5MwCsj79qQDnhyxciBypSkweTRrbTKdcnzKUcM243tmh8sCq?=
 =?iso-8859-15?Q?WSZRQ69XXqN77qDBursBE7wed8jxlMTsgu4WtPZqJFtn8feUDyoevPCe8?=
 =?iso-8859-15?Q?U8clVMcOVCC4roV4QiVnR94fjaSxDLtk8AIpidI3xkV606o8SE71uCcbN?=
 =?iso-8859-15?Q?P0T1U7kL1n8DXxpkCgR/6DqYa76KHWm5Ypf9UGDYbfAGa5ei/NWgyB//+?=
 =?iso-8859-15?Q?nBHeGgQKztpZWFUlRHYWFwFfsjCOo4WMxQYkVrNPEEKhM7WTO9is5jLM+?=
 =?iso-8859-15?Q?dlvu71pakXj3m/UpePCOgA1CIbk+ah+VYGzQrCYcWBv8Hhhtk61jcIrTz?=
 =?iso-8859-15?Q?RTr9TKpKgI40uX7Aejp6Cgyc0ZHAeU0gMtjSicYt7Aq9FMF2q8js0PgjF?=
 =?iso-8859-15?Q?bxS867mTOOk3YAyliQV0lL5e0wvln/l0OtBBC29iQLBDx1MFsK9rCw/ga?=
 =?iso-8859-15?Q?U756i2bHZc2wto5l3W5zLi+8cma6Fyqo54LX7MSy6qShOuj35lIywMCTx?=
 =?iso-8859-15?Q?ZQKJiiay60Qp1g8dGeLwoXxreHptDCdeLo/YrAIWtJSxncpw317rQN9LB?=
 =?iso-8859-15?Q?U5zzFyWgUvAANqCcOUWo1FdzT59e7jkosAhpmFqq7ewmx6z1/n+/m7A?=
 =?iso-8859-15?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <497958C073311B4E865770B1C487FAD1@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666af1d7-dcf9-4f1a-e7f0-08d951282942
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 17:58:38.1618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RILzCO1JRq2SJGfnCF0m4lXrPo9rxGRLYDuXHotPRT0wPm04eDTPWcI5s7Z6bVsBj4fJKl2+C2P92xcY0gcgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4945
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi,

On 7/27/21 7:25 PM, Mimi Zohar wrote:
> Hi Simon,
>=20
> On Tue, 2021-07-27 at 16:33 +0000, THOBY Simon wrote:
>> While users can restrict the accepted hash algorithms for the
>> security.ima xattr file signature when appraising said file, users
>> cannot restrict the algorithms that can be set on that attribute:
>> any algorithm built in the kernel is accepted on a write.
>>
>> Define a new value for the ima policy option 'func' that restricts
>> globally the hash algorithms accepted when writing the security.ima
>> xattr.
>>
>> When a policy contains a rule of the form
>> 	appraise func=3DSETXATTR_CHECK appraise_hash=3Dsha256,sha384,sha512
>> only values corresponding to one of these three digest algorithms
>> will be accepted for writing the security.ima xattr.
>> Attempting to write the attribute using another algorithm (or "free-form=
"
>> data) will be denied with an audit log message.
>> In the absence of such a policy rule, the default is still to only
>> accept hash algorithms built in the kernel (with all the limitations
>> that entails).
>>
>> On policy update, the latest SETXATTR_CHECK rule is the only one
>> that apply, and other SETXATTR_CHECK rules are deleted.
>>
>> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
>=20
> Sorry, I was just getting to this patch, when you re-posted the patch
> set.  In the future, I'll make sure the responses are sent in quick
> succession.
>=20

The mistake is mine, I will wait more between submission next time (and it =
would also
be more reasonable of me to spam less the ML), sorry!

> There are a number of assumptions related to the IMA policy:
> - A builtin policy may be replaced by a custom policy.
> - Depending on the Kconfig, the policy rules may not change be updated.
> - Subsequent to replacing the builtin policy with a custom policy,
> rules may only be appended, based on the Kconfig.
>=20
> The locking around the policy rules is dependent on these assumptions.=20
> Removing policy rules is a major change that needs to be considered
> carefully.  Why should "func=3DSETXATTR_CHECK"  be treated any
> differently than any other policy rule?  How would an attestation
> server know which setxattr rule was enabled at the time the file was
> appraised?
>=20

You're right, the "user convenience" gain is probably not much anyway, whil=
e the complexity burden
arising from deleting nodes from a list in reverse order with potentially m=
ultiple concurrent readers
is high, even with RCU doing most of the work.

I will drop that in a future revision of the patchset.

> thanks,
>=20
> Mimi
>=20

Many thanks for all the time you already spent on reviewing this work,
Have a nice evening (or day, with timezones and all),
Simon=
