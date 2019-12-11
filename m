Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D134811A279
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 03:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLKC4l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 21:56:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727859AbfLKC4l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 21:56:41 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB2ppmP050587
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 21:56:40 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wthkh417e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 21:56:39 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 11 Dec 2019 02:56:37 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Dec 2019 02:56:34 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBB2uXPa45809956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 02:56:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C211EA405F;
        Wed, 11 Dec 2019 02:56:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F485A405B;
        Wed, 11 Dec 2019 02:56:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.214.111])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Dec 2019 02:56:33 +0000 (GMT)
Subject: Re: Ramifications of INTEGRITY_PLATFORM_KEYRING
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthias Gerstner <mgerstner@suse.de>,
        linux-integrity@vger.kernel.org
Date:   Tue, 10 Dec 2019 21:56:32 -0500
In-Reply-To: <20191204135715.GB11974@f195.suse.de>
References: <20191204135715.GB11974@f195.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121102-0016-0000-0000-000002D3AA74
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121102-0017-0000-0000-00003335C513
Message-Id: <1576032992.4579.122.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110025
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Matthias,

On Wed, 2019-12-04 at 14:57 +0100, Matthias Gerstner wrote:
> I was able to still get things to work by building my own custom kernel
> with the custom CA being built into the kernel which is a lot of more
> effort, however, and a scenario we can't easily support for our
> customers.
> 
> I can understand the reasoning of that new option, that trusting
> arbitrary platform certificates shipped with the hardware might not be a
> good idea. I wonder, however, whether moving these certificates from
> .secondary_trusted_keys to .platform doesn't also affect other
> components than just IMA?
> 
> I would be interested in your view on this and any advice.

The pre-boot keys were probably also being used to verify 3rd party
kernel modules.  If the kernel was built with
CONFIG_SYSTEM_EXTRA_CERTIFICATE, the customer could insert their key
post build.[1]  This would obviously require the kernel to be
resigned.

I agree there needs to be a simpler way of including a customer key,
without requiring them to resign the kernel.  Do you have some
thoughts?

Mimi

[1] c4c361059585 ("KEYS: Reserve an extra certificate symbol for
inserting without recompiling")

