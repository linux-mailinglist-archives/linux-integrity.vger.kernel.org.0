Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41E331DBF5
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Feb 2021 16:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhBQPMi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Feb 2021 10:12:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233681AbhBQPE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Feb 2021 10:04:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11HF39Zf127806;
        Wed, 17 Feb 2021 10:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/6wXyRiKtag76Uas8odstYAw9ozKCm1AGlHsC88M7ls=;
 b=gaNCCzI0H/TXOiIUU27B7o28uTSqj3XtSxLIuoFUpz2LYFDHyzj/v1cBuxfRDn4C1oFw
 LBwee3RXs2Hp6vWOlk9nHZ/lv3JqSAsKQyAILnCWCB7fvL9NPNxOYoulzCu+9YHZMHbB
 L+skP42xiNcKzPsxhxRCxKDI8NiBOOrcDYdep57PMWiXDHMqy7oRrYpuVVJzXfflNeqc
 +T9Djy7RG+KNpmdHl1zX2gOAj2qzZ6fkixwlWBbQv3JJLBVgwsCVfMWOCAH1P9T0++og
 hNI5zNB7yzFP0iogvWg1yxMwkNkwxTfa0F7HCsAOkjmpoWHX0HnwkA24KXZzm56pboNZ BQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36s4v41b6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 10:04:05 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11HF1odu005279;
        Wed, 17 Feb 2021 15:04:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 36rw3u8dpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 15:04:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11HF3lC735389902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 15:03:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E0034205C;
        Wed, 17 Feb 2021 15:03:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44E8D4204C;
        Wed, 17 Feb 2021 15:03:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.42.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Feb 2021 15:03:57 +0000 (GMT)
Message-ID: <ab197aa9719b4218ab497b55f0bc78a0dadc83dd.camel@linux.ibm.com>
Subject: Re: [PATCH v2] IMA: support for duplicate data measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Feb 2021 10:03:55 -0500
In-Reply-To: <20210217024649.23405-1-tusharsu@linux.microsoft.com>
References: <20210217024649.23405-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_12:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

The Subject line could be improved.  Perhaps something like - "IMA:
support for duplicate measurement records"

On Tue, 2021-02-16 at 18:46 -0800, Tushar Sugandhi wrote:
> IMA does not measure duplicate data since TPM extend is a very expensive
> operation.  However, in some cases, the measurement of duplicate data
> is necessary to accurately determine the current state of the system.
> Eg, SELinux state changing from 'audit', to 'enforcing', and back to
> 'audit' again.  In this example, currently, IMA will not measure the
> last state change to 'audit'.  This limits the ability of attestation
> services to accurately determine the current state of the measurements 
> on the system.

This patch description is written from your specific usecase
perspective, but it impacts file and buffer data measurements as well,
not only critical data measurements.  In all of these situations, with
this patch a new measurement record is added/appended to the
measurement list.  Please re-write the patch description making it more
generic. 

For example, I would start with something like, "IMA does not include
duplicate file, buffer or critical data measurement records ..."

thanks,

Mimi

> 
> Update ima_add_template_entry() to support measurement of duplicate
> data, driven by a Kconfig option - IMA_DISABLE_HTABLE.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

