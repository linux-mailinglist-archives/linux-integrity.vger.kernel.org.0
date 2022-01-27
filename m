Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8021149EB36
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 20:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245543AbiA0Tmi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 14:42:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245263AbiA0Tmi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 14:42:38 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RJcvYs004439;
        Thu, 27 Jan 2022 19:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pj1NKpQbH5pDAnBSZ6ZEh9QlXO/BiqZbqDY+xndFINQ=;
 b=ArUxI9xaJnMkc1m/ctLCFYLNYmbLq3j2EEPW4mhMbS9IlLQbC5TY9UfNjI0rROw8oi2u
 7Nenc9Kw208aEa34ewjzCclSsBPFlk3fwTXjIHEbvEsw5Mf9A/IPg5Z2ojFaMI6CKW8L
 kj/hAWY4b6vnUz2W72pUtbiUQOD1vwG3Rkl2QU69f4BVgaJRuSGnTogXzI6KA37+VfUD
 7aE7dUsxtatUu6TDk/yPMTijyr5M7lKvY4Qa3TxaNgrREIyycOlQLxpaTtt34tYfMd9e
 rvwjXlhUBpdZccrCAub+uelWNFBE9pxymSVFE6ei+5HiJHp6SpFnmqHMZ7AUWN5lZ7D/ gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv1brrc7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 19:42:24 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RJfDZQ012915;
        Thu, 27 Jan 2022 19:42:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv1brrc77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 19:42:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RJc5TI000707;
        Thu, 27 Jan 2022 19:42:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3dr9j9uchp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 19:42:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RJgIqw44499358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 19:42:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E45C25205A;
        Thu, 27 Jan 2022 19:42:17 +0000 (GMT)
Received: from sig-9-65-89-165.ibm.com (unknown [9.65.89.165])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5DB0C52050;
        Thu, 27 Jan 2022 19:42:15 +0000 (GMT)
Message-ID: <38a2c2b2d1829e9949bd984958e880e54ae7cf5c.camel@linux.ibm.com>
Subject: Re: [PATCH v9 06/23] ima: Move arch_policy_entry into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 27 Jan 2022 14:42:14 -0500
In-Reply-To: <20220126091104.jbedxrewojcmvy3u@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
         <20220125224645.79319-7-stefanb@linux.vnet.ibm.com>
         <20220126091104.jbedxrewojcmvy3u@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EFrkMEN0Vw9pu_-7IXT2CP4xF-M23kgt
X-Proofpoint-ORIG-GUID: 8-dUcX1JxUB9y2GW9MGQi7Rsn0s9ApOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-01-26 at 10:11 +0100, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 05:46:28PM -0500, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Move the arch_policy_entry pointer into ima_namespace.
> > 
> > When freeing the memory set the pointer to NULL.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> 
> Only relevant for the initial imans (for now) since it is derived from a
> boot parameter. Maybe mention this in the commit message.

Enabling architecture specific policy rules is based on
CONFIG_IMA_ARCH_POLICY.  As the name implies, each architecture is free
to define their own policy rules.  For example on x86, based on the
secure boot mode both measurement and signature verification rules are
defined for the kexec kernel image and kernel modules. Similarly on
powerpc, different measurement and signature verification rules for the
kexec kernel image and kernel modules are defined based on whether
trusted boot, secure boot, or both are enabled [2].

As neither kexec nor loading kernel modules are applicable, the
architecture policy rules are limited to initial imans.

[1] security/integrity/ima/ima_efi.c 
[2] arch/powerpc/kernel/ima_arch.c

> 
> Move into struct ima_namespace looks good,
> Acked-by: Christian Brauner <brauner@kernel.org>

Thanks, Christian.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

