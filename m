Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257655BC1A3
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Sep 2022 05:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiISDKP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Sep 2022 23:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiISDKN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Sep 2022 23:10:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A4CE3C
        for <linux-integrity@vger.kernel.org>; Sun, 18 Sep 2022 20:10:11 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J2xxAS005156;
        Mon, 19 Sep 2022 03:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XM+zoaBtNZk0CcE4WPaoCR/Vp/Eit2wE+YdPeGhwlQ0=;
 b=SbdyDfYRKvOZP4f/MhrMPMMAbNEvIE74mX5VtrIQpjGJo5bgGt2O6drrf8ruj69ueU8+
 B5eDf4HPTVczOJvw9r6oBzMCh3dfhr9LFz+LyA0b1F2Ozi6cPWi1GoeT5BlwF6FYCVku
 w+JXhIxjqDm/3Je6OIZ2vGsNZjA2X66g5xOB7gQBwXCXrBi3qAQH/r22kHIh+Kcrh2qB
 HsI9dAp5NxCl58iZfD6RQ3trfALTltK91VJbAtBAVfGB8txo2EFb4rThxGP9sMwj+L8h
 84L6buxzZhl8AeCpuXnWaXjouKZaEEsediNS2RhTI2p4Au51yro9I1ffD8V/7H/TFt/o Tg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jpc27cm5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 03:10:10 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28J36FrD001978;
        Mon, 19 Sep 2022 03:10:09 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3jn5v9du0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 03:10:09 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28J3A98U1049186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 03:10:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8C77BE04F;
        Mon, 19 Sep 2022 03:28:29 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89694BE051;
        Mon, 19 Sep 2022 03:28:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.183.187])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Sep 2022 03:28:29 +0000 (GMT)
Message-ID: <f9f13bcd35ea54bd24007e4fa244ed346ac89c00.camel@linux.ibm.com>
Subject: Re: User questions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Williams <ken@williamsclan.us>
Cc:     linux-integrity@vger.kernel.org
Date:   Sun, 18 Sep 2022 23:10:08 -0400
In-Reply-To: <CADrftwOM6mWaQ+xNbExbgcHisAirBe1vQSRdCEtET7xqQ=_bjg@mail.gmail.com>
References: <CADrftwOUDT5CuwHsrgEM1GTu_N3TAhZTpxFBERKa7zwUHkQscw@mail.gmail.com>
         <d70a3bf1bf8245ed54bd55eafd4fbb98fd08e316.camel@linux.ibm.com>
         <CADrftwOM6mWaQ+xNbExbgcHisAirBe1vQSRdCEtET7xqQ=_bjg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UslfIXMQhpealC4tDwSZrSMwvN6rViRz
X-Proofpoint-ORIG-GUID: UslfIXMQhpealC4tDwSZrSMwvN6rViRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_01,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 mlxlogscore=901 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190020
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ken,

On Sun, 2022-09-18 at 16:47 -0700, Ken Williams wrote:
> Hi Mimi and others and thanks for responding.
> 
> My primary goal right now is to develop an understanding of IMA for
> the purpose of determining if and how it can be useful for my application.
> For that, I have outlined below a few implementation scenarios.
> 
> I have played around with IMA a bit so as to get some understanding of
> the process, configuration and capabilities.  This included creating a
> policy file
> for measurements as well as signing files and enabling appraisal.
> All of this was done on-target and obviously putting a private key on the target
> is not right but this was a familiarization exercise.  In any case, my current
> understanding is that options available to me, without a TPM device, are:
> 
> - Measure files which have no security.ima=<HASH> xattr
>   In this case I can detect if a previously measured file has changed.
>   This is a nice exercise for getting my feet wet but without a TPM,
>   it is hard to embrace this alone as being a security tool that can
>   work for me.
> 
> - Measure files which do have a security.ima=<HASH> xattr
>   This is a good step up but I cannot see how this enables the
>   detection of a 'bad' but properly labeled file without a link to
>   some kind of file validation server.  Again, I have no TPM.

In either case, the TPM is needed for remote attestation.  The 'ima-
sig' template includes the file signature, if available, in the
measurement list.   With just the public key, the remote attestation
server can verify the file signature.

> 
> - Attest to files which have been signed with a private key prior to
> installation
>  With this, I understand that as long as I have control over the file
> installation
>   process, I have a level of protection equal to that of the signing algorithm.
>   If I am correct, I also understand that this applies only to immutable files,
>   typically executable binaries.  The process of signing the files would be
>   off-target and outside the scope of my questions and comments here.
> 
>   Again, I do not have a TPM so I understand that an off-line attack
> is still possible
>   but it looks like this might be the best I can get out of IMA for
> the environment
>   I have.

IMA file hashes are used for mutable files, which cannot be signed. 
When file hashes are stored as security.ima, EVM HMAC must be used to
detect off line file metadata changes.

-- 
thanks,

Mimi

