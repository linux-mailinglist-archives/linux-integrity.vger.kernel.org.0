Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0C30100A
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Jan 2021 23:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbhAVWdI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Jan 2021 17:33:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728336AbhAVWcs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jan 2021 17:32:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10MMBnIe176153;
        Fri, 22 Jan 2021 17:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=Zm+DimOO07FuMeGIC0cmqs92h64q23WHojDOHXY+Ebg=;
 b=Sj22m8F8w7eM+4jc/LuvXWHTRMkika1mjas7ne+eAVNmNlO3KNuTvhpP7Yqkql04HWqK
 dD7h8Z+l1XAwiy0fAtj7K6AJVav98WNSC9pnn/QYVlrYNcYI64vxLYijgIWNZ72PlaSV
 bnJON56IDOqMxPjENefvb7agW7LqX9Sd9PAzl2sEO0ehBdMYZlX83IsyVh7gr4AT5vS/
 lKGYYYoWF8afKVTu5aChCL+cX6aHhzXApCoIKPwtdKsAyTdcUN4BBiKodZ7AcrXk6Yma
 +SzzZZMKfkhc2s+pjjU5+Cz6699iNs8waoacQ+F/lypDDyU558P+TqfcW60iILdynTdg LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36879kgc8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 17:31:57 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10MMCtr4181758;
        Fri, 22 Jan 2021 17:31:56 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36879kgc8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 17:31:56 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10MMVGl2010896;
        Fri, 22 Jan 2021 22:31:56 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 367k0xq1ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 22:31:56 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10MMVt5s7078600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 22:31:55 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC652AE06B;
        Fri, 22 Jan 2021 22:31:55 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 641D9AE05C;
        Fri, 22 Jan 2021 22:31:53 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.213.112])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Jan 2021 22:31:53 +0000 (GMT)
References: <20210121173003.18324-1-nramas@linux.microsoft.com>
 <20210121173003.18324-2-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, gregkh@linuxfoundation.org,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] ima: Free IMA measurement buffer after kexec syscall
In-reply-to: <20210121173003.18324-2-nramas@linux.microsoft.com>
Date:   Fri, 22 Jan 2021 19:31:51 -0300
Message-ID: <87bldg1u3s.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_15:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=870
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> IMA allocates kernel virtual memory to carry forward the measurement
> list, from the current kernel to the next kernel on kexec system call,
> in ima_add_kexec_buffer() function.  This buffer is not freed before
> completing the kexec system call resulting in memory leak.
>
> Add ima_buffer field in "struct kimage" to store the virtual address
> of the buffer allocated for the IMA measurement list.
> Free the memory allocated for the IMA measurement list in
> kimage_file_post_load_cleanup() function.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")

Good catch.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
