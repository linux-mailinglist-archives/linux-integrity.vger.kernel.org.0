Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD572A48C1
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgKCO41 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 09:56:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728087AbgKCO4T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 09:56:19 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3EXvAX083657;
        Tue, 3 Nov 2020 09:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wwBNzfpsSPmSsQz65LMWGCrtvQLcfVtSMBGkdkyC3MU=;
 b=s7nq2whjfZtOMzbXNJ5esd2sqRQzcwitui9hWfGHEGsxsz3kE+qs87i2x7ZM01Q7ad4w
 cSugHQDzcgBBgyoluEQ91obYvuxBNsxvxBwLBVDXrFormrI2vbv+Nm8DGmKJIC0NZx+5
 22VlYNamyuIKoEdlmijwgA41n3uUFFUBhACzex09TBU5Ym6rJxpZNqOcw0ICvvc+soL9
 +97CIe8mqtDsFr/T9DSlyZzGwFdawAzcR+5duStjceYPLyFkxgvYwbJ8kNkbJYKd5Yqo
 E8fxVBi9R6xFZaN0puPf+hisuuHksxNVHz8TB5eyjnMEOL/YOXmQLbl+WiDqoXsWKlyk Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jyyta3px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 09:55:26 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3EZ27b091221;
        Tue, 3 Nov 2020 09:55:22 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jyyta3js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 09:55:22 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3En4u0011411;
        Tue, 3 Nov 2020 14:55:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 34h0f6sq5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:55:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3EtBKw64946674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 14:55:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B902FA4064;
        Tue,  3 Nov 2020 14:55:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4477FA4054;
        Tue,  3 Nov 2020 14:55:04 +0000 (GMT)
Received: from sig-9-65-255-16.ibm.com (unknown [9.65.255.16])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 14:55:04 +0000 (GMT)
Message-ID: <506372c01decf59bc2ef39c92a86ba7f6f2ae81b.camel@linux.ibm.com>
Subject: Re: [PATCH v8 1/4] powerpc: Refactor kexec functions to move arch
 independent code to drivers/of
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Date:   Tue, 03 Nov 2020 09:55:03 -0500
In-Reply-To: <20201030174429.29893-2-nramas@linux.microsoft.com>
References: <20201030174429.29893-1-nramas@linux.microsoft.com>
         <20201030174429.29893-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 suspectscore=11 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Fri, 2020-10-30 at 10:44 -0700, Lakshmi Ramasubramanian wrote:
> The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
> carrying forward the IMA measurement logs on kexec for powerpc do not
> have architecture specific code, but they are currently defined for
> powerpc only.

^ ... logs on kexec, do not have architecture specific code, but are
currently limited to powerpc.

> 
> remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
> the IMA log entry from the device tree and free the memory reserved
> for the log. These functions need to be defined even if the current
> kernel does not support carrying forward IMA log across kexec since
> the previous kernel could have supported that and therefore the current
> kernel needs to free the allocation.

The first paragraph describes these function as "handle carrying
forward the IMA measurement logs on kexec", while this paragraph says
"are used to remove the IMA log entry".  Consider listing all of the
functions being moved in the first paragrah, then "handle carrying
forward" could be expanded to "carrying ... and removing".

> 
> Rename remove_ima_buffer() to remove_ima_kexec_buffer().
> Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in
> drivers/of/fdt.c. A later patch in this series will use these functions
> to free the allocation, if any, made by the previous kernel for ARM64.

- ^Define -> Move
- Three functions are being moved, but only two are listed. 
"do_get_kexec_buffer" is not mentioned.
- Don't refer to a later patch, but explain the purpose here.  For
example, "Move ... , making them accessible to other archs."

> 
> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
> "linux,ima-kexec-buffer", that is added to the DTB to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.

The above two paragraphs describe renaming a function and defining a
chosen node.  These two preparatory changes should be made,
independently of each other, prior to this patch.  This patch should be
limited to moving code, with the subject line truncated to "move arch
independent code to drivers/of".

thanks,

Mimi

