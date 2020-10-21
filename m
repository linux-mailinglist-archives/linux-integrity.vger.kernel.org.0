Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D302951F5
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409454AbgJUSED (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Oct 2020 14:04:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409359AbgJUSED (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Oct 2020 14:04:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09LH3elh066933
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2020 14:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=gMyWI0VC91Cka0fj9xPlOarvarnmpkOQgFfu6//Eh3I=;
 b=rmYmNmraTG+C61K/1j7fSi6b9bIClX1NCqdvrwVD17j18j+Y+l0OMa9aH5kqWY/hzTYY
 EfhMnPFucQck05nJ29i6I96KP1nZv4G/EF9brGwFJ/WzTeGAw4DMe2taMo8bCL7WOoZv
 /V6WiQOB4e2QVE2HY/4m2AGelxnxdK1GkejIcJNHVRD5rIEFDpLTN0jUbgfzXBfnfX3G
 XUvdv8KhUcrwLxnLBTJNbpWKb5brBsIEZyUNXYwYIhxdoNNYLTQmulfilyyYlDFdYt82
 R239FfQhxZVkFx8XncvbvpNKpWDEXMhldHG28eHLbvgHsSu2OjvbUjArsgU5ZZz6wYwj zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34aqftcy47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2020 14:04:02 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09LI2Rkl083380
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2020 14:04:01 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34aqftcy2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 14:04:01 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09LI253I007068;
        Wed, 21 Oct 2020 18:04:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 347qvhcm76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 18:03:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09LI3v9V32571708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 18:03:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92D8DA4053;
        Wed, 21 Oct 2020 18:03:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE082A4057;
        Wed, 21 Oct 2020 18:03:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.92.86])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Oct 2020 18:03:56 +0000 (GMT)
Message-ID: <6806f4a638f6ad00cb68a69e62ab06b23dd6eb84.camel@linux.ibm.com>
Subject: Re: Measuring kernel modules with IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 21 Oct 2020 14:03:55 -0400
In-Reply-To: <CAEjxPJ6Uw+wJYHW6ZWvWgxDXUW8wvv4-y8Sgy+SVeiH91XxiDg@mail.gmail.com>
References: <CAEjxPJ6Uw+wJYHW6ZWvWgxDXUW8wvv4-y8Sgy+SVeiH91XxiDg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_09:2020-10-20,2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-10-19 at 12:23 -0400, Stephen Smalley wrote:
> Why is it that IMA only supports measuring kernel modules if they are
> loaded via finit_module(2)?  Why can't init_module(2) pass a buffer
> with the module content after copying from userspace to IMA and let
> IMA measure that buffer?  Is that an intentional design choice or just
> no one has asked for it?
> 
> At present, it appears that kmod will fall back to using
> init_module(2) when kernel modules are compressed on disk, and that
> such compression is common in Linux distributions.  Hence, if one has
> a func=MODULE_CHECK rule, kernel module loading fails unless one
> enables module.sig_enforce and even then the modules aren't actually
> measured, just signature checked.
> 
> Potential userspace-only solutions are to decompress the kernel
> modules (but this deviates from distribution packaging/practice plus
> obviously impacts storage) or change kmod to decompress to a tmpfs
> file and use finit_module() on that.
> 
> But I'm not sure why we can't just measure the buffer with the
> kernel's copy of the module during init_module(2) and get a
> measurement that way.

Right, nobody asked for it (and lack of time to implement it).  I was
under the impression that we were moving away from init_module and that
eventually it would be deprecated.

With Kees' new security_kernel_post_load_data() hook being upstreamed
in this open window and the recent IMA support for verifying appended
signatures, support for both measuring and verifying kernel modules
loaded via the init_module syscall should be possible.

thanks,

Mimi

