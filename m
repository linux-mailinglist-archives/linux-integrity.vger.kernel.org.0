Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9930573AECB
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jun 2023 04:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFWCwk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jun 2023 22:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjFWCwk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jun 2023 22:52:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C32110;
        Thu, 22 Jun 2023 19:52:38 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N2lgCc006723;
        Fri, 23 Jun 2023 02:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=RVm125GpA+1HVQbzGy//ia9dU0l+5tLkVFavKaQYjzw=;
 b=sw7IO5Yr5ooD7hVnf1f+5UcLFKHQpGeUj6942kPhFdBBj3i7J0Dx2EppuOUQKCVbHOl8
 mkIm3VVuDoK4TCiaqoc2zTDTLmJedbn1y4KFf7SlIMaRSkZ0ZzNdmx/TVyg7e84m5oAT
 wYikFR/BLFuYgiajKYp7+QK5rONto6Vhn8wJW5doRAC9WLPmKNzRunV0b/8TKRWpyU6B
 yBxFO/dQSaC06PgOsGLLXk4e1AdlQ9woRlgNXIYgd6HhysLE0e6miUub9jSOjfcRO8S4
 hSPcwYSC7nCsEvxVSlpBTlAdYma9Tzb8uJS0kF0GXSWeNv/BkaVquSXdg6mDE/MtOMQ6 sg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd2wv01kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 02:52:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35N0KUfT027259;
        Fri, 23 Jun 2023 02:52:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r943e3vy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 02:52:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35N2qGMs58720550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 02:52:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD1DB20040;
        Fri, 23 Jun 2023 02:52:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4312F20043;
        Fri, 23 Jun 2023 02:52:15 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.65.200])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jun 2023 02:52:15 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [6.4-rc6] Crash during a kexec operation
 (tpm_amd_is_rng_defective)
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <3f5a37f1-70e0-3dcf-3bd3-acc8a04e53ee@amd.com>
Date:   Fri, 23 Jun 2023 08:22:04 +0530
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, jarkko@kernel.org,
        linux-integrity@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <425CE5FE-FE54-493D-A74E-7EBC812544BB@linux.ibm.com>
References: <99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com>
 <87o7lhfmoh.fsf@mail.lhotse>
 <CA0088E4-2851-4AFF-94F8-2A07C5CDA8D8@linux.ibm.com>
 <675a8893-429d-05be-b647-089b249c814c@leemhuis.info>
 <87o7l7oer1.fsf@mail.lhotse> <3f5a37f1-70e0-3dcf-3bd3-acc8a04e53ee@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fzee60I0I2G4wkal38UFV33R3U9zVDls
X-Proofpoint-GUID: Fzee60I0I2G4wkal38UFV33R3U9zVDls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_18,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230020
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On 22-Jun-2023, at 8:08 PM, Limonciello, Mario =
<Mario.Limonciello@amd.com> wrote:
>=20
>=20
> On 6/22/2023 7:36 AM, Michael Ellerman wrote:
>> "Linux regression tracking (Thorsten Leemhuis)" =
<regressions@leemhuis.info> writes:
>>> Hi, Thorsten here, the Linux kernel's regression tracker. =
Top-posting
>>> for once, to make this easily accessible to everyone.
>>>=20
>>> As Linus will likely release 6.4 on this or the following Sunday a =
quick
>>> question: is there any hope this regression might be fixed any time
>>> soon?
>> No.
>>=20
>> I have added the author of the commit to Cc, maybe they can help?
>>=20
>> The immediate question is, is it expected for chip->ops to be NULL in
>> this path? Obviously on actual AMD systems that isn't the case,
>> otherwise the code would crash there. But is the fact that chip->ops =
is
>> NULL a bug in the ibmvtpm driver, or a possibility that has been
>> overlooked by the checking code.
>>=20
>> cheers
>=20
> All that code assumes that the TPM is still functional which
> seems not to be the case for your TPM.
>=20
> This should fix it:

Yes, with this change kexec works correctly.

Since Aneesh first reported this problem including reported by credit =
for him

Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>

-Sachin=
