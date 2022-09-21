Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ADF5E5450
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiIUUPn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiIUUPl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 16:15:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B71476470;
        Wed, 21 Sep 2022 13:15:39 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LK0pcC028776;
        Wed, 21 Sep 2022 20:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SZF5TNSqq6NRus5abObkIrIGNqtWxqQC+LRQXnbsqVM=;
 b=eXgbvK0cQ6heGtwUt58+92DX+qLADFu3otTQG3oI67ewKKAsQfJO0E3dMRUbGlUvQv5o
 djNPCDfvq0sxHEsDTXxyrXLheMRkRYRVrFFFI9uhJ+W41z9+Jl7aen87cfdPvtPZz/eL
 NxcD52/JyfnEYOFcvo7GXJ7ubZ3TiYwZjInNKBQj89F+RiCze9C1Fjy7hhBLkosfEuSp
 wjZ12IFcrOUJQpCkzHBTYcfV9+aPx8cjh+6rMuXAxKHlKQVLmWp701eIT6KHpalM7pqO
 HMsIpPfF6qpS+Ggv5yikECZZzLuF6g43nWAzBfUD6KxmUGICNA6lsBz2u5o32QE4yJLA qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jr99c0d81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 20:15:25 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28LK0wrV029080;
        Wed, 21 Sep 2022 20:15:25 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jr99c0d7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 20:15:25 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28LK62Pq020111;
        Wed, 21 Sep 2022 20:15:23 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3jn5v9m3f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 20:15:23 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28LKFLb949021186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 20:15:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15FF558058;
        Wed, 21 Sep 2022 20:15:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32AA058057;
        Wed, 21 Sep 2022 20:15:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.98.41])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Sep 2022 20:15:21 +0000 (GMT)
Message-ID: <2bc656bf67af52e0b9a68e91c5b574e0ab4ffa8e.camel@linux.ibm.com>
Subject: Re: TPM: hibernate with IMA PCR 10
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
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
Date:   Wed, 21 Sep 2022 16:15:20 -0400
In-Reply-To: <YylDYU+KTX/KJpqU@kernel.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
         <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
         <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
         <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
         <Yw7L+X2cHf9qprxl@kernel.org>
         <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
         <96360ec16b21d8b37461a5de083ff794f3604300.camel@linux.ibm.com>
         <Yxl8tbJERqrmsgpU@kernel.org>
         <96cfd1f3f084f6d145bd22e0989dc046fe15b66a.camel@linux.ibm.com>
         <YylDYU+KTX/KJpqU@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nYsIoN94-ze8p8u3WUK02-G4Cj6Dvdxt
X-Proofpoint-GUID: 7zUvdGs0MUqUn3ugZU0VqM3dTHHGe5Vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_11,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209210134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-09-20 at 07:36 +0300, Jarkko Sakkinen wrote:
> On Sat, Sep 10, 2022 at 10:40:05PM -0400, Mimi Zohar wrote:
> > On Thu, 2022-09-08 at 08:25 +0300, Jarkko Sakkinen wrote:
> > > On Wed, Sep 07, 2022 at 07:57:27PM -0400, Mimi Zohar wrote:
> > > > On Wed, 2022-09-07 at 13:47 -0700, Evan Green wrote:
> > > > > On Tue, Aug 30, 2022 at 7:48 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Aug 29, 2022 at 02:51:50PM -0700, Matthew Garrett wrote:
> > > > > > > On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
> > > > > > > >
> > > > > > > > On 5/4/2022 7:20 PM, Evan Green wrote:
> > > > > > > > > Enabling the kernel to be able to do encryption and integrity checks on
> > > > > > > > > the hibernate image prevents a malicious userspace from escalating to
> > > > > > > > > kernel execution via hibernation resume.  [snip]
> > > > > > > >
> > > > > > > > I have a related question.
> > > > > > > >
> > > > > > > > When a TPM powers up from hibernation, PCR 10 is reset.  When a
> > > > > > > > hibernate image is restored:
> > > > > > > >
> > > > > > > > 1. Is there a design for how PCR 10 is restored?
> > > > > > >
> > > > > > > I don't see anything that does that at present.
> > > > > > >
> > > > > > > > 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> > > > > > > > restored?
> > > > > > >
> > > > > > > They're part of the running kernel state, so should re-appear without
> > > > > > > any special casing. However, in the absence of anything repopulating
> > > > > > > PCR 10, they'll no longer match the in-TPM value.
> > > > > >
> > > > > > This feature could still be supported, if IMA is disabled
> > > > > > in the kernel configuration, which I see a non-issue as
> > > > > > long as config flag checks are there.
> > > > > 
> > > > > Right, from what I understand about IMA, the TPM's PCR getting out of
> > > > > sync with the in-kernel measurement list across a hibernate (because
> > > > > TPM is reset) or kexec() (because in-memory list gets reset) is
> > > > > already a problem. This series doesn't really address that, in that it
> > > > > doesn't really make that situation better or worse.
> > > > 
> > > > For kexec, the PCRs are not reset, so the IMA measurment list needs to
> > > > be carried across kexec and restored.  This is now being done on most
> > > > architectures.  Afterwards, the IMA measurement list does match the
> > > > PCRs.
> > > > 
> > > > Hibernation introduces a different situation, where the the PCRs are
> > > > reset, but the measurement list is restored, resulting in their not
> > > > matching.
> > > 
> > > As I said earlier the feature still can be supported if
> > > kernel does not use IMA but obviously needs to be flagged.
> > 
> > Jumping to the conclusion that "hibernate" is acceptable for non-IMA
> > enabled kernels misses the security implications of mixing (kexec) non-
> > IMA and IMA enabled kernels. 
> > I would prefer some sort of hibernate marker, the equivalent of a
> > "boot_aggregate" record.
> 
> Not sure if this matters. If you run a kernel, which is not aware
> of IMA, it's your choice. I don't undestand why here is so important
> to protect user from doing illogical decisions.
> 
> If you want non-IMA kernels to support IMA, CONFIG_IMA should not
> probably even exist because you are essentially saying that any
> kernel play well with IMA.

That will never happen, nor am I suggesting it should.

Enabling hibernate or IMA shouldn't be an either-or decision, if at all
possible.  The main concern is that attestation servers be able to
detect hibernation and possibly the loss of measurement
history.  Luckily, although the PCRs are reset, the TPM
pcrUpdateCounter is not.

I would appreciate including a "hibernate" marker, similar to the
"boot_aggregate".

Mimi

