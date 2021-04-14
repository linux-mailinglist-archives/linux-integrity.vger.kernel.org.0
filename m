Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE635FA06
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Apr 2021 19:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhDNRrS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Apr 2021 13:47:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231582AbhDNRrS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Apr 2021 13:47:18 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EHYNnx127298;
        Wed, 14 Apr 2021 13:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MbZsb/v7yQpKNMU3XWPBQBv2x1KCZH01IJ2DSEUO4OY=;
 b=pY9OfRKS/qairq7uYkv7ZO2ytWsf5FFROJdQpKayzRpiWPgXAZbrUvGnGk1FGhCeLaQF
 4JcA9jG5zNhkuU7O5vDR3jHJ2M7CvV5eVejyej4HZrXQn8MT7TNAISbE47FL0JcKZUKy
 R72QKE1l4iPtuObkYjTDB95R+4y2b527qjeRm/I1VgX5AwNOOcFjMs7kXxpldhE3XYF6
 kLK9ZR6GL3omTO5MMzcHbI8ETLVt+8aSdzNTDj6E4xzZ/GdN3YvBczAx+KWLtHSF7mX3
 LPSjdA0HIM/3hF2f+DSINCvlw/4eSJ9ka7MJFmFSade+oQjuelf/yf5ejdyaZNRCTsDD AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x2dsmpjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 13:46:54 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13EHZ8N4129582;
        Wed, 14 Apr 2021 13:46:54 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x2dsmph9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 13:46:54 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13EHj0KH016589;
        Wed, 14 Apr 2021 17:46:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 37u39h9uk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 17:46:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13EHkRMT16974200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 17:46:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FB15A407D;
        Wed, 14 Apr 2021 17:46:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADC3BA4068;
        Wed, 14 Apr 2021 17:46:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.89.102])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Apr 2021 17:46:47 +0000 (GMT)
Message-ID: <630cc0a27a0db8fd790a767300ae0a7f2540bdc2.camel@linux.ibm.com>
Subject: Re: null-ptr-deref in integrity_inode_free()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 14 Apr 2021 13:46:46 -0400
In-Reply-To: <20210414115055.mayc4aeonsklgwks@wittgenstein>
References: <20210414115055.mayc4aeonsklgwks@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wm4lSqq2XapT8yytI_ztSB6NoKGkAXs7
X-Proofpoint-ORIG-GUID: MSI0vVEP1rxbsFYxzKI-fMT75Z8emtv3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_10:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Christian,

On Wed, 2021-04-14 at 13:50 +0200, Christian Brauner wrote:
> Hey,
> 
> [Resending since the previous mail somehow hasn't made it onto the list.]
> 
> While working on a patch to port ecryptfs to use clone_private_mount() I
> hit the splat in [1] with v5.12-rc6 (Without any of my changes.). To
> reproduce this you can use the config in [5]. Then run the scripts [2]
> and [3] in two terminals. The kernel command line was [4]:
> 
> while true; do ./test.sh; done
> while true; do ./test2.sh; done
> 
> and wait for [1] to appear.
> 
> The two test scripts aren't specifically designed to trigger this issue.
> They were stress tests for my ecryptfs clone_private_mount() port. They
> just allow to trigger this issue.
> 
> From a very uninformed position it seemed that:
> 
> void integrity_inode_free(struct inode *inode)
> {
>         struct integrity_iint_cache *iint;
> 
>         if (!IS_IMA(inode))
>                 return;

Thank you for all the details.

A builtin IMA policy wasn't specified on the boot command line.  Unless
a custom IMA policy is loaded, it shouldn't get beyond this
point.   Before looking any farther, I would appreciate your confirming
that you've loaded a custom IMA policy.  To see if a policy has been
loaded, cat /sys/kernel/security/ima/policy.

thanks,

Mimi

> 
>         write_lock(&integrity_iint_lock);
>         iint = __integrity_iint_find(inode);
>         ^^^^^
> >>>>>>> is somehow NULL?
> 
>         rb_erase(&iint->rb_node, &integrity_iint_tree);
>         write_unlock(&integrity_iint_lock);
> 
>         iint_free(iint);
> }
> 
> So I've placed a BUG_ON() in there:
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 0ba01847e836..d5152b5ef517 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -152,6 +152,7 @@ void integrity_inode_free(struct inode *inode)
> 
>         write_lock(&integrity_iint_lock);
>         iint = __integrity_iint_find(inode);
> +       BUG_ON(!iint);
>         rb_erase(&iint->rb_node, &integrity_iint_tree);
>         write_unlock(&integrity_iint_lock);
> 
> and indeed, I get:
> 
> [  266.308227] ------------[ cut here ]------------
> [  266.308592] kernel BUG at security/integrity/iint.c:155!
> [  266.312120] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> [  266.313898] CPU: 0 PID: 5867 Comm: rm Tainted: G            E     5.12.0-rc6-clone-private-mount-8a97af3f33b5 #380
> [  266.317651] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/LXD, BIOS 0.0.0 02/06/2015


