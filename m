Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE35B10B0
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Sep 2022 01:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIGX6B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 19:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGX57 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 19:57:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E21A026E;
        Wed,  7 Sep 2022 16:57:58 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287MK2NA012222;
        Wed, 7 Sep 2022 23:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=820+EKhapsnrzr5gXlP9Eaag26KNAvbVppsq0pW4h2g=;
 b=NveRvg/AolxNpuFItmcXnq43BdQLMd01KfjF8hlnMMRahiheOwmhagDeH8jjZ3aMAzaW
 56mI0kw+hPctOTgpGut7DpAF5MQ6gnuWMiCEl+xbwSJnCPHT2aKLlWVHSfZ9NhLM5G38
 Bjw/Q8VFssTGxEC7rlG5ZRurwWOaAGQvgvwndmnQ+qN66ZdZ8dnEjEcucNi4Suu1IG7r
 i6nXkcd5k7f1CQwGFrECngMorCM9teCmi794TZ7DUoyUppXYB+rhoDuDCxsMPFWYUiS9
 W8I6X8JUFvqZZLVlYpYHAWlQRyT0ZAXDBGpAPX/Sb0wPWLYPdXxzjqTy+ct1HM0nc24q tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jf40j20qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 23:57:32 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 287Nq66E009220;
        Wed, 7 Sep 2022 23:57:31 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jf40j20qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 23:57:31 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 287NoUPc013473;
        Wed, 7 Sep 2022 23:57:30 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3jbxjam34g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 23:57:30 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 287NvTvo64094688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Sep 2022 23:57:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B86AC05F;
        Wed,  7 Sep 2022 23:57:29 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14C15AC05E;
        Wed,  7 Sep 2022 23:57:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.79.89])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Sep 2022 23:57:27 +0000 (GMT)
Message-ID: <96360ec16b21d8b37461a5de083ff794f3604300.camel@linux.ibm.com>
Subject: Re: TPM: hibernate with IMA PCR 10
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Evan Green <evgreen@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <mgarrett@aurora.tech>,
        Ken Goldman <kgold@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 07 Sep 2022 19:57:27 -0400
In-Reply-To: <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
References: <20220504232102.469959-1-evgreen@chromium.org>
         <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
         <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
         <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
         <Yw7L+X2cHf9qprxl@kernel.org>
         <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9fr5S-25Hmtv7OjmfbpBHRCJtpKAb59a
X-Proofpoint-ORIG-GUID: KB8x7MGRKA0OymWJYKLJ504g9cIYrlyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-09-07 at 13:47 -0700, Evan Green wrote:
> On Tue, Aug 30, 2022 at 7:48 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Mon, Aug 29, 2022 at 02:51:50PM -0700, Matthew Garrett wrote:
> > > On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
> > > >
> > > > On 5/4/2022 7:20 PM, Evan Green wrote:
> > > > > Enabling the kernel to be able to do encryption and integrity checks on
> > > > > the hibernate image prevents a malicious userspace from escalating to
> > > > > kernel execution via hibernation resume.  [snip]
> > > >
> > > > I have a related question.
> > > >
> > > > When a TPM powers up from hibernation, PCR 10 is reset.  When a
> > > > hibernate image is restored:
> > > >
> > > > 1. Is there a design for how PCR 10 is restored?
> > >
> > > I don't see anything that does that at present.
> > >
> > > > 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> > > > restored?
> > >
> > > They're part of the running kernel state, so should re-appear without
> > > any special casing. However, in the absence of anything repopulating
> > > PCR 10, they'll no longer match the in-TPM value.
> >
> > This feature could still be supported, if IMA is disabled
> > in the kernel configuration, which I see a non-issue as
> > long as config flag checks are there.
> 
> Right, from what I understand about IMA, the TPM's PCR getting out of
> sync with the in-kernel measurement list across a hibernate (because
> TPM is reset) or kexec() (because in-memory list gets reset) is
> already a problem. This series doesn't really address that, in that it
> doesn't really make that situation better or worse.

For kexec, the PCRs are not reset, so the IMA measurment list needs to
be carried across kexec and restored.  This is now being done on most
architectures.  Afterwards, the IMA measurement list does match the
PCRs.

Hibernation introduces a different situation, where the the PCRs are
reset, but the measurement list is restored, resulting in their not
matching.

-- 
thanks,

Mimi




