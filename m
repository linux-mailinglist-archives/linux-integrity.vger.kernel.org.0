Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D475BAEF4
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Sep 2022 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIPOKg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Sep 2022 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiIPOKf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Sep 2022 10:10:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D590839
        for <linux-integrity@vger.kernel.org>; Fri, 16 Sep 2022 07:10:34 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GE1Xhw031615;
        Fri, 16 Sep 2022 14:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EMK8pEyBJbq68SSGE5kOOtUra+3U78irinATYq8xmdw=;
 b=JNX3xNmHJHUMwBEE0yq11iY05XoWDNS3X5Vy3tf+EzKD2WqIieSjNwivmTUQoADCuEZZ
 qpwGspvuqRgzt8OQJVEs2cqPoI9113Q/kQRraWEyaJc3sQT6DgyXLRCNkipvYRS3abE3
 7idOWbvNnzjGugNBLyepfB2wDoxDWMmNVEHESOhbJUiNlUjIvpb0IMXGiaDdBh48ivnR
 BprkE1nvmSnDPQkR/CzKpGfy4/iFSAGHPlc2ixLMrjmLx7KPHBCA8jbVmyjBjMB35DR5
 Fa6OefmaOevUByuewh96bebYr94mh/wyvGSPSs/EghtD4StQj2KGbrDBG4fk5bgihySl vg== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jmthxgf7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 14:10:34 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28GE6Qwc015565;
        Fri, 16 Sep 2022 14:10:32 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03wdc.us.ibm.com with ESMTP id 3jm91w5906-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 14:10:32 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28GEAWcr43188656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 14:10:32 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17836AE060;
        Fri, 16 Sep 2022 14:10:32 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA135AE05C;
        Fri, 16 Sep 2022 14:10:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.93.89])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Sep 2022 14:10:31 +0000 (GMT)
Message-ID: <d70a3bf1bf8245ed54bd55eafd4fbb98fd08e316.camel@linux.ibm.com>
Subject: Re: User questions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Williams <ken@williamsclan.us>, linux-integrity@vger.kernel.org
Date:   Fri, 16 Sep 2022 10:10:31 -0400
In-Reply-To: <CADrftwOUDT5CuwHsrgEM1GTu_N3TAhZTpxFBERKa7zwUHkQscw@mail.gmail.com>
References: <CADrftwOUDT5CuwHsrgEM1GTu_N3TAhZTpxFBERKa7zwUHkQscw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 43L0VY1aluJoRZsCGXr1WgNu3zR9Jx1M
X-Proofpoint-ORIG-GUID: 43L0VY1aluJoRZsCGXr1WgNu3zR9Jx1M
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209160104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-09-15 at 22:36 -0700, Ken Williams wrote:
> I am looking at Linux IMA to try and understand how it might be useful
> for my application.  I am playing around with it a bit now and as I do
> so, I am finding myself with questions about the usage model and user
> configuration.  With that opening, my first question is:
> 
> Is this an acceptable forum for asking user and usage questions?
> 
> If yes, then let me describe my environment;
> I am running an older kernel, 4.14.238, on a fsl device in a system
> that does not have a TPM although I am running an implementation of
> OP-TEE.  In my case, I want to do the best I can to prevent file
> modification, without considering off-line attacks.  My deployment
> mechanism is os-tree.
> 
> When I look at the measurement capability, I cannot see how that can
> help since I do not have a TPM in which to anchor the measurements so
> it looks like I need to implement appraisal.  I did find this link,
> https://sourceforge.net/p/linux-ima/mailman/linux-ima-user/?viewmonth=201409&viewday=10,
> where Mimi says "Enabling IMA-appraisal is anything but simple". and I
> actually found that kind of re-assuring as it confirmed that my
> learning curve in this area may not be out of line.  My plan is to
> pre-sign the files prior to installation and I see that effort as
> being outside of the scope of my inquiries here.  So now, does it lookg
> like I am starting in the right direction?
> 
> Thanks for reading through this and I welcome any comments.

Let's add some context to the above quote.  One of the differences
between IMA-appraisal and IMA-measurement is that IMA-appraisal
requires quite a bit of configuration (e.g. keys, signing files, and
policy).  This is in comparison to IMA-measurement, which requires just
a policy.

As long as the IMA-appraisal policy encompasses just those things that
can and should be signed, enforcing the IMA-appraisal policy is
straight forward:
- Create a local CA key and build it into the kernel.
- Create a public/private key pair signed by the local CA key
- Sign files.
- Load the public key on the IMA keyring.
- Load the IMA appraise policy.

Examples of the first 2 steps can be seen in the ima-evm-utils README. 
Examples of the last two steps can be seen in dracut 98integrity
modules.  systemd can be configured to load an IMA custom policy.

-- 
thanks,

Mimi

