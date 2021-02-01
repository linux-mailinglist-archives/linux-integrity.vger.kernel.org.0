Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA43F30AFF4
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 20:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBATCV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 14:02:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62014 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230110AbhBATCC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 14:02:02 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111IovYk150700;
        Mon, 1 Feb 2021 13:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=8DE4OP4mhALUjkAEcT0iR3ZPkE1qJ/LakdUJ1QBmFuU=;
 b=GO9yg/nz+H7ud1OYtbKwLI1X436wQpgKt/gsH6JHR2LhGCgCJvrn41Pf1NsNGQ239dYr
 MvYNQHCC2M6pQp0Oqkt57GtY8tf6jmq+4pHEY11rWxC7S0gY8zwn05JCjIpOz65BaVlk
 lrRZhtE/ypgi8aS5yVbMJz/ut/AcGK1Q0dDD3h9fra9BDXba/EoTzRe8I03GSVXdrWzP
 vNi1/rzHh541p+whRA+ujFssDLpvvRtNS/s8suiivkh5VclJW1FxROpGoaguHt6E8NW6
 smrUd+oMIMgv+5SkwcNRCUy2w25C0HhF+zN1qG8clh4aJ59sNNrcQsDkaTFOUEYp0f1L Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36epwtrq68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 13:58:21 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111IowWw150724;
        Mon, 1 Feb 2021 13:58:18 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36epwtrq53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 13:58:17 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111Iq3dD001957;
        Mon, 1 Feb 2021 18:58:16 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 36cy39cww1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 18:58:16 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111IwFg036635016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 18:58:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23482C6055;
        Mon,  1 Feb 2021 18:58:15 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 176A9C6059;
        Mon,  1 Feb 2021 18:58:07 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.217.20])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon,  1 Feb 2021 18:58:07 +0000 (GMT)
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-10-nramas@linux.microsoft.com>
 <20210127165208.GA358@willie-the-truck>
 <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
 <20210127184319.GA676@willie-the-truck>
 <871re5soof.fsf@manicouagan.localdomain>
 <d6ddcab2f9db25f49e89f37e1cb4f59ad42651e6.camel@perches.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Joe Perches <joe@perches.com>
Cc:     Will Deacon <will@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
In-reply-to: <d6ddcab2f9db25f49e89f37e1cb4f59ad42651e6.camel@perches.com>
Date:   Mon, 01 Feb 2021 15:58:06 -0300
Message-ID: <87czxjpqdd.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=706
 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010093
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Joe Perches <joe@perches.com> writes:

> On Thu, 2021-01-28 at 00:52 -0300, Thiago Jung Bauermann wrote:
>> The problem is that this patch implements only part of the suggestion,
>> which isn't useful in itself. So the patch series should either drop
>> this patch or consolidate the FDT allocation between the arches.
>> 
>> I just tested on powernv and pseries platforms and powerpc can use
>> vmalloc for the FDT buffer.
>
> Perhaps more sensible to use kvmalloc/kvfree.

That's true. Converting both arm64 to powerpc to kvmalloc/kvfree is a
good option. I don't think it's that much better though, because
kexec_file_load() is called infrequently and doesn't need to be fast so
the vmalloc() overhead isn't important in practice.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
