Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D485B4B52
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Sep 2022 04:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIKCkc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 10 Sep 2022 22:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIKCkc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 10 Sep 2022 22:40:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2622DA99;
        Sat, 10 Sep 2022 19:40:31 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28B2TMEU029343;
        Sun, 11 Sep 2022 02:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4naiZMvhQFA1N/YinogkLOjn/TYgcpPArZTdOs6n4YI=;
 b=jNAkIgqCvYY6thQkg2GPSDRsE+0RSbFEwWICpGuwS3fvi8q9NvWVjEpw1BZ7TZYJ/DbS
 Xp4zMclaUeGySAIyvnRq8tdfp4sPyBUeOlvgJze10HuTzZwC+ojVVHwFDgfWHtwDM7sE
 OglulsvEGb6fZ4hFVSix1tlYIJir1ZMSUYP2vvlqCreiyc12ODALibHZ2/1rpOBaEnGY
 Ey5SzOnsFqIMZ8c+A97AeXkwX0UtF4KKT/W/AwfVBRjWCDG/0R9Bf6dB7a1L9NMB/1Gp
 AQpOrNupHdnX3EvoLM9l6PVUnaNm8FPmRvOmnV2XyYJs7w0CJSsxZSHjVAOqPkO3p4bI Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jh6x7r4y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Sep 2022 02:40:09 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28B2Xt8n021422;
        Sun, 11 Sep 2022 02:40:09 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jh6x7r4y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Sep 2022 02:40:09 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28B2Kgib006255;
        Sun, 11 Sep 2022 02:40:08 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3jgj79pj6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Sep 2022 02:40:08 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28B2e7JJ7995934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Sep 2022 02:40:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A512BE051;
        Sun, 11 Sep 2022 02:52:52 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 822C1BE04F;
        Sun, 11 Sep 2022 02:52:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.113.148])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 11 Sep 2022 02:52:51 +0000 (GMT)
Message-ID: <96cfd1f3f084f6d145bd22e0989dc046fe15b66a.camel@linux.ibm.com>
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
Date:   Sat, 10 Sep 2022 22:40:05 -0400
In-Reply-To: <Yxl8tbJERqrmsgpU@kernel.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
         <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
         <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
         <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
         <Yw7L+X2cHf9qprxl@kernel.org>
         <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
         <96360ec16b21d8b37461a5de083ff794f3604300.camel@linux.ibm.com>
         <Yxl8tbJERqrmsgpU@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cg2JVNB4isbz9rma7TQQL0Vedqi_fAK8
X-Proofpoint-ORIG-GUID: UWz3ktNCM6GLe7YoLiAoJnQHDyaoYYjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-11_01,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209110007
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-09-08 at 08:25 +0300, Jarkko Sakkinen wrote:
> On Wed, Sep 07, 2022 at 07:57:27PM -0400, Mimi Zohar wrote:
> > On Wed, 2022-09-07 at 13:47 -0700, Evan Green wrote:
> > > On Tue, Aug 30, 2022 at 7:48 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 29, 2022 at 02:51:50PM -0700, Matthew Garrett wrote:
> > > > > On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
> > > > > >
> > > > > > On 5/4/2022 7:20 PM, Evan Green wrote:
> > > > > > > Enabling the kernel to be able to do encryption and integrity checks on
> > > > > > > the hibernate image prevents a malicious userspace from escalating to
> > > > > > > kernel execution via hibernation resume.  [snip]
> > > > > >
> > > > > > I have a related question.
> > > > > >
> > > > > > When a TPM powers up from hibernation, PCR 10 is reset.  When a
> > > > > > hibernate image is restored:
> > > > > >
> > > > > > 1. Is there a design for how PCR 10 is restored?
> > > > >
> > > > > I don't see anything that does that at present.
> > > > >
> > > > > > 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> > > > > > restored?
> > > > >
> > > > > They're part of the running kernel state, so should re-appear without
> > > > > any special casing. However, in the absence of anything repopulating
> > > > > PCR 10, they'll no longer match the in-TPM value.
> > > >
> > > > This feature could still be supported, if IMA is disabled
> > > > in the kernel configuration, which I see a non-issue as
> > > > long as config flag checks are there.
> > > 
> > > Right, from what I understand about IMA, the TPM's PCR getting out of
> > > sync with the in-kernel measurement list across a hibernate (because
> > > TPM is reset) or kexec() (because in-memory list gets reset) is
> > > already a problem. This series doesn't really address that, in that it
> > > doesn't really make that situation better or worse.
> > 
> > For kexec, the PCRs are not reset, so the IMA measurment list needs to
> > be carried across kexec and restored.  This is now being done on most
> > architectures.  Afterwards, the IMA measurement list does match the
> > PCRs.
> > 
> > Hibernation introduces a different situation, where the the PCRs are
> > reset, but the measurement list is restored, resulting in their not
> > matching.
> 
> As I said earlier the feature still can be supported if
> kernel does not use IMA but obviously needs to be flagged.

Jumping to the conclusion that "hibernate" is acceptable for non-IMA
enabled kernels misses the security implications of mixing (kexec) non-
IMA and IMA enabled kernels. 
I would prefer some sort of hibernate marker, the equivalent of a
"boot_aggregate" record.

-- 
thanks,

Mimi

