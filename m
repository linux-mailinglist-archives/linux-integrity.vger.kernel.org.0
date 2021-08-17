Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279193EE6CE
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Aug 2021 08:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhHQGov (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Aug 2021 02:44:51 -0400
Received: from mail-db8eur05on2126.outbound.protection.outlook.com ([40.107.20.126]:27265
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238005AbhHQGou (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Aug 2021 02:44:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuD2FHMfUq7BR/1PsdgMxNFAA/VWVlocAPv9OmukVhxLQuw/5IysASL1jZ1qen7xggv7P+2P6/W0Ym2woZnxcKYTsbVeiQ3JZokMBUNFTP/OT15OK5XPEl/eFf4pzmFyZLjxPurJyGBWY+5gqtTKVb5TBteeAbaWq13AXl0OURdhQ46s2lziNPN2qSRXDUEVvdmjl1rQi4WxvO8DxN74xAnKekXCmQtBrNd8orM3OjhpwWzUsL0rr0GxYS1Zb9FK9UosFAqRFq/mysGQW0Lo/uvs1qdi6tt3OUcgNsSHnp8QhDfT9cciGmZvOqkiiPoYDIL3QJq2y11XTUCfXWmRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq1uAQsf10GC721yGa1vd0i2k7mRUoSieA5qWea9kQc=;
 b=V8T/RKbDrtPIGgmgfILDiJv2iv5D/ytOCEHDCiTh9eKTTq2heVBWhSuxRpizgdseRgIha5CWajeL6YZo4Z+oWsq2P8pJA9m6Gu4COVdW7x7TJ0VAO8evPSGrDLv8jYT4VTjNDIUfgtUVK3cNknaEgo6bV7XcGvNiWhhdiBERq5OYBNFGx+a2aZD48m8oPyEz5b7rZvS1ss8HSUfRsx1Bv4l9TMx2J+KWSlTmm3TgH/UBAmvv2I/AZGFQB0KZHKtk+JLNvkngJ055TwM0chuylmci2GNTWqKz89c8N3D5yBTDM/n+i/8KjQLvYwMtv8M+5Cl32BjjP91pwKfyizfXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq1uAQsf10GC721yGa1vd0i2k7mRUoSieA5qWea9kQc=;
 b=ubX12frQq5Rx2Lr8qHIpNYJySTmQpeEe0Kd0777I0ii0wLsEuujLNIytcWpR2+ld2Gt0sI9a/7wpt4VrRHgs9YpVidsFlAjGCZNzwr+JFhqY0G55WaNSw7G+/gdYXZWMKlfLPJqBLj2i8knI84Ge56XwrfDE2DtOo82+3G6aPfk=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2290.eurprd09.prod.outlook.com
 (2603:10a6:208:db::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 06:44:16 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 06:44:16 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Subject: Re: [PATCH v8 6/6] IMA: prevent SETXATTR_CHECK policy rules with
 unavailable algorithms
Thread-Topic: [PATCH v8 6/6] IMA: prevent SETXATTR_CHECK policy rules with
 unavailable algorithms
Thread-Index: AQHXknZABL7BGu5ZKkWVcYT+5iM91qt2tOYAgACMxIA=
Date:   Tue, 17 Aug 2021 06:44:15 +0000
Message-ID: <80e3157d-f497-1d91-8331-2f4ed5ba39c9@viveris.fr>
References: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
 <20210816081056.24530-7-Simon.THOBY@viveris.fr>
 <aa0c635a090ff6849c4334566d6721ee036c491f.camel@linux.ibm.com>
In-Reply-To: <aa0c635a090ff6849c4334566d6721ee036c491f.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18f7b219-88ab-4289-a134-08d9614a6e9c
x-ms-traffictypediagnostic: AM0PR09MB2290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB2290E2D94F94AB99673E8A3594FE9@AM0PR09MB2290.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qcqEukpijAmgVRo0NnlrWeX9TA1l9N9YinkRbhm59wJXbG3F1/J6BIxsz+5KI6Jx+hUu1ouZKCMySGfR07D/S1F7uzbufmv5m9ojRmJKrlkEi18V12o0bepy0b1GpSnd0FbAehSzgnONteSNhytBop4jq6TGGwnrMsrmWAWIB6ZSOfpj4zGXwtqz8T19ywepFCenLd5RzmN3kYGZ/FvbPTPcFANQy+TFIZ3takosdyYCtdnPZCXOhn+D2s4sSX5WZ8Og+NlJzl7qcFoiLS6xZBo3dIVClkhGgSUundS3wDWY4de4rgTWWIPF5Q+qjYc4CpkqueP6yv+2hBrLFzitfW9+I+sTN5z2x3DINtyEiO6KWLAUSYeDkvW/DvxiZQv/C2rnlafW6m4VznayJNTwIDvYcXKWb48bJlVrpZO1yOYAQoVEG/5Ju+WIJ3i63YjAdRrAlOV0EqrfPtsOOJy6UG+QsZ1nobX7MQnU6sMaFLlU4FDtKmwhbe4KHoSvdLzLJqQh0FcGcdn7FjDF00Zulzb76WRdbVPRgAcprvpBTQKGaBu13RtjlJKhBRmeS3OSU0h0o6m7zzvO0MvbpwHsn5gaQb7AUTXlL5JmdgN5G/DWjFSBHhJB5/kd73bEGCYQ/THGlF7maeuoXVSI3KVAMf0IDWqZ5vPDEzFa0zWNAn6AJDdizsY3/omTNnM3wlm2dkiPemSXNZcUgurwT8b0MP5yjQmVmdexDLY31UNP98GMbbNwieqmirjpAeSTtdk2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39830400003)(396003)(136003)(6512007)(6636002)(8936002)(2616005)(5660300002)(36756003)(6506007)(71200400001)(83380400001)(110136005)(53546011)(316002)(26005)(66556008)(2906002)(38100700002)(122000001)(66446008)(6486002)(8676002)(66476007)(478600001)(186003)(66946007)(91956017)(38070700005)(76116006)(86362001)(31686004)(31696002)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?fkYFx6M2VWHeFHgxmGdQ1/CHqT10642Je2P9j8Owf3ID9YZgt+AhozsNC?=
 =?iso-8859-15?Q?oVR683VS+evuzy+C2/eUEDzFmltxsJQden5rOIrLzzW6l1imSr1KTJCud?=
 =?iso-8859-15?Q?TGJf9HNqwQPj9vOngg1yuhUA93BH3B5YH6IZVgsBOJPq6zFVsEZjswo/D?=
 =?iso-8859-15?Q?tpWdQi6lkO+SKXu5s9fZBixhqIdNhOGVdWFTtqHJAx5FuaEqo/dASvzoV?=
 =?iso-8859-15?Q?3jkETFuOPhT0ynqXm9G520HFwdLSbyHHhA1+VuQnPUxFvEnAsPJzWtF4i?=
 =?iso-8859-15?Q?3gRQCdJGcZ1t/ierrn0qy300LWUzxZDWFhAowYdE2zRlT2tWfK71AavQg?=
 =?iso-8859-15?Q?7OVMoQZ+86wPJs5QONPlBYJ/NRSXRKgCGpOPTKQf0PFt9OkX+yXG6VHwL?=
 =?iso-8859-15?Q?R68LQ3zXCOpvmCTj3RNiBraKlFAx3gyIS98IMN1bYXHpdzhGjMZ0FTqrq?=
 =?iso-8859-15?Q?9DNmZUe3XiPpyrOCVlRxQOW9AaTEzAAOli0z0kUvtZsVrbDzRpROGEglN?=
 =?iso-8859-15?Q?cM0/o3DuRN1XIKPzYTtNTI4oy6hW6XESNs1Zy8jbw7kWHrbQsr0nHQegh?=
 =?iso-8859-15?Q?ubpCPwx8xrhR/xdTdF05A8q9qwgAzAyT0iE/FQqzes3JLfW1+am/Z735C?=
 =?iso-8859-15?Q?xhEubzGLO6DVZV2cnpWpY2xt9faz8vNn2Ns5VVTgD/HtUC7ayzZCmmVFt?=
 =?iso-8859-15?Q?cJBKtNxIDRcrMQLD8X0NnzrH1DswP19OHfi+x2IR7Qm8RhF4ZkAYR5hlY?=
 =?iso-8859-15?Q?RRLe+fFz8TkCfjoZZSnTavJSydNs9MLq5/KzNyvrku17Q5NN/N1YzIDIz?=
 =?iso-8859-15?Q?KnseER/QueYaRQkCjnVfEF0HovoCdhwmIcfJOtaVx5qJWMMoeXrnQau0P?=
 =?iso-8859-15?Q?xFAnxneKtmACYHSEUoPr9ufBCSvpaMDEMSDNYhf0BE9QxqoL223R5ogpx?=
 =?iso-8859-15?Q?g71tPAAtim3dsiZCXslHwKJCDtH5rLytA4LTpuuhLYqEklvXwgwU8uT8I?=
 =?iso-8859-15?Q?WN6usn9Utbe6WhXAyw4kQqds69iJbI1mKmymUq2eC40Cy2kLImH9M9FXY?=
 =?iso-8859-15?Q?upHwpDtBQqc0dt5TJVP9s53Y0zvL9cikZbbWFtFvU1Om2EEPIxME7dXgz?=
 =?iso-8859-15?Q?zeDSYnWFFUlM7V0WE0uOB/Jylgj3oTmwy4tyx9k1aAo543ZtJmP4J0iEd?=
 =?iso-8859-15?Q?jcwzahf6q2Q2/DN6FvGqf+D5QL2yeKjuWndHzjOmDwAbp+h51mDuT7c9C?=
 =?iso-8859-15?Q?b6lyXdtC4dYRfhKnR3htD0ESxv/66wDCg36w3v1/KeUjeW8VRmRMLMXpV?=
 =?iso-8859-15?Q?aKJ01BEXoqwdr3CuMlCY/I8JkgwnTh9j6jJ7mDO/vwCQX72KHgfrIViiZ?=
 =?iso-8859-15?Q?hYyKK8ZANikqCCsLxO4DIlF3ihEnpdJm6yOjpWLgx+UEq8D/Jd+wcsg?=
 =?iso-8859-15?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <CD2FECD7495533469B90EE8727F1820D@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f7b219-88ab-4289-a134-08d9614a6e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 06:44:16.0089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3EQRzCFn8g+oS3XuGmUIIdFOo3SPdUM6ZjteibZuY6NkrbNC4w8yB0j0z4d4Rs5+C4NpGpVcytdIR8/RWVheg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2290
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 8/17/21 12:20 AM, Mimi Zohar wrote:
> On Mon, 2021-08-16 at 08:11 +0000, THOBY Simon wrote:
>> SETXATTR_CHECK poliy rules assume that any algorithm listed in the
>> 'appraise_algos' flag must be accepted when performing setxattr()
>> on the security.ima xattr.
>> However nothing checks that they are available in the current kernel.
>> A userland application could hash a file with a digest that the kernel
>> wouldn't be able to verify. However, if SETXATTR_CHECK is not in use,
>> the kernel already forbids that xattr write.
>=20
> I assume the above couple of sentences are a continuation of the
> previous paragraph and concatenated them.  If it really is meant to be
> a separate paragraph a blank line needs to separate them.

No you're right, it makes more sense as a single paragraph.

>=20
>>
>> Verify that algorithms listed in appraise_algos are available to the
>> current kernel and reject the policy update otherwise. This will fix
>> the inconsistency between SETXATTR_CHECK and non-SETXATTR_CHECK
>> behaviors.
>>
>> That filtering is only performed in ima_parse_appraise_algos() when
>> updating policies so that we do not have to pay the price of allocating
>> a hash object every time validate_hash_algo() is called in
>> ima_inode_setxattr().
>>
>> Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
>=20
> Thanks, Simon.  Before pushing out the entire patch set, including this
> one, to next-integrity-testing branch,  I reverted the tag re-ordering,=20
> fixed the line length of the sample appraise rule, and added the commit
> number (for stable) in the patch description.  Please verify.

Looks great to me!

>=20
> While testing, I noticed similar support is needed for appended
> signatures.  For example, "scripts/sign-file" can be used to sign
> kernel modules or the kernel image.
>=20
> Sample kexec rules:
> measure func=3DKEXEC_KERNEL_CHECK template=3Dima-modsig
> appraise func=3DKEXEC_KERNEL_CHECK appraise_type=3Dimasig|modsig appraise=
_algos=3Dsha256

Oh yeah, I didn't think of that. I'll take a look to see if it's
simple to add these checks on module and kernel signatures.

>=20
> thanks,
>=20
> Mimi
>=20
>=20
>=20

Thanks again,
Simon=
