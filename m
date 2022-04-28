Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA65133A3
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Apr 2022 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346208AbiD1M3m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Apr 2022 08:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346210AbiD1M3k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Apr 2022 08:29:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662F51313;
        Thu, 28 Apr 2022 05:26:26 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SCCpWj009073;
        Thu, 28 Apr 2022 12:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GTjvof9BOvzt9KszuU0HAs7EcErUoYk+LZGTFwI7OEA=;
 b=AQysz9IwMLKYmH607ih4CMnKsX/IDn0vGYI4e1dE+tVwGqjdYnFkgMDLeJAVOc78n4Ko
 j3MIRShz4IEOkHg1xI5DD22vvSC6po21Gd6xPfVjXriMLflZxppM71nFH0yxNhsKgkoV
 rvgvHCdrmNn+1k4O5WSnZM4xIt/D7AddTTG9//5BBCpJtawyrthrNCytY9z0wXbqgj2G
 6fRIIrsCpylicW157bXgUOfPX4V+YaplAGLXKcs6PPF5U5pTrACef31hfa3aETx6dUdC
 +8Z91Ug8mMqqiBQ34F7KkBiWOkOG/rB6FQXOhizvJWpEu7/pBSLW8u0Ga3yp9/LWO0R/ 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtqv0aj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 12:25:57 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23SCE0GD013138;
        Thu, 28 Apr 2022 12:25:57 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtqv0ahe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 12:25:57 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23SCDoVb015134;
        Thu, 28 Apr 2022 12:25:55 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj7gke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 12:25:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23SCPqCJ40501578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 12:25:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 912D911C066;
        Thu, 28 Apr 2022 12:25:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 708A111C04A;
        Thu, 28 Apr 2022 12:25:50 +0000 (GMT)
Received: from sig-9-65-71-66.ibm.com (unknown [9.65.71.66])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Apr 2022 12:25:50 +0000 (GMT)
Message-ID: <01f8dd3d0df722530b0f7605b9f3dbbaa0d743c1.camel@linux.ibm.com>
Subject: Re: [PATCH] Carry forward IMA measurement log on kexec on x86_64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Thu, 28 Apr 2022 08:25:39 -0400
In-Reply-To: <YmpvJ5JziMS+M3j+@noodles-fedora-PC23Y6EG>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
         <12108732c287a85a417927de37cb027cefae6e06.camel@linux.ibm.com>
         <YmfgyyUs6TgM/Czx@noodles-fedora-PC23Y6EG>
         <41f9d261a7750e576460360c512a8e4c1492efa3.camel@linux.ibm.com>
         <YmgiWpHWH6K1feyt@noodles-fedora-PC23Y6EG>
         <06a1242830ddb84c52cd77e548c71d40a0eb5e63.camel@linux.ibm.com>
         <YmpvJ5JziMS+M3j+@noodles-fedora-PC23Y6EG>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r4-QbDjgmfFXhhxPb1dZs_JbNLakYkhW
X-Proofpoint-ORIG-GUID: W0Dwg6aou80dZodOBB1VuQ31rxYD0RAc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_01,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-04-28 at 10:40 +0000, Jonathan McDowell wrote:
> On Tue, Apr 26, 2022 at 02:10:58PM -0400, Mimi Zohar wrote:
> > On Tue, 2022-04-26 at 16:48 +0000, Jonathan McDowell wrote:
> > > Also there's an issue about the fact that we measure the kexec pieces
> > > even if we don't actually do the kexec; there's no marker that confirms
> > > the kexec took place. It's separate to this patch (in that it affects
> > > the device tree kexec infrastructure too) but it's conceivable that an
> > > attacker could measure in the new kernel details and not actually do the
> > > kexec, and that's not distinguishable from the kexec happening.
> > > 
> > > One approach might be to add a marker in the kexec ima buffer such that
> > > if it's not present we know the kexec hasn't happened, but I need to
> > > think through that a bit more.
> > 
> > I'm not quite sure what you mean by "we measure the kexec pieces".  The
> > kexec file load syscall calls kernel_read_file_from_fd() to read the
> > kernel image into a buffer.  The measurement record included in the IMA
> > measurement list a hash of the buffer data, which is exactly the same
> > as the hash of the kernel image.
> > 
> > The kernel kexec self tests only do the kexec load, not the execute. 
> > For each kexec execute you'll see an additional "boot_aggregate" record
> > in the IMA measurement list.  At least for the moment I don't see a
> > need for additional marker.
> 
> You're right, of course. I'd missed the fact we measure the
> boot_aggregate into IMA_MEASURE_PCR_IDX on boot, so although we'll
> update PCRs related to the kexec on load the IMA PCR won't get updated
> until we've actually done the reboot. So no need for anything extra.

To clarify, after the kexec load, the IMA measurement list contains the
kexec'ed kernel image measurement.  The TPM was also extended with that
measurement.  Nothing prevents verifying the IMA measurement list at
this point, before the kexec execute, though depending on policy it
might result in additional measurements.

The IMA "pcr=" policy rule option allows specifying a different PCR
than the default IMA_MEASURE_PCR_IDX.

To summarize, with CONFIG_IMA_ARCH_POLICY enabled, both measurements -
kexec'ed kernel image, boot_aggregate - are being added to the IMA
measurement list and extended into the default TPM PCR.  Measuring the
kexec'ed kernel image and extending the TPM with the measurement
happens at some point before the system is rebooted.  The
"boot_aggregate" is the first measurement after boot/soft boot.

thanks,

Mimi

