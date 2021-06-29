Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA68C3B71A8
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 13:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhF2L6d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 07:58:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbhF2L6c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 07:58:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TBXpkC096694
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 07:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=oMvxX33o9/gJz3ypwdKDVde5R/B5eE5sjn/YI6jhTzE=;
 b=NMCZnPD2OXXjVYTHOhoA9JWREPEZLm7BnwLU5t9m331ZwdEw5YNL+jsDxW/ns9zgetfY
 ZtYNiaqkEk/X7vurPjexmbhmI9pkvQztTPIUCD0pDoaffuU0wXDlmOJZhKNeDnBU/s2s
 iqLy+AHRyk7Un53Fj/GR+PIOI2k0zH0TlyKIocSSprpPZxN/qxIKXN9M56lXhOFiYBrL
 tb38TOuq9wPtRREuCch7PTwa/eizB/CFxwFVcquU6FVuZniu5NJsSO9H9c5OEQgJnvG0
 Oylx/B9kD9UwoR9y/SxVdwTmNUwRqXzU3pXp2NBYPA/brwyvk6f3vUVIVurvH7fvgD4j eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g19cty18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 07:56:05 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15TBZdPn100898
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 07:56:05 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g19cty0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 07:56:04 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TBsUu7029089;
        Tue, 29 Jun 2021 11:56:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 39duv8h8qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 11:56:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TBsQWE24117554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 11:54:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 246F2A4072;
        Tue, 29 Jun 2021 11:56:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51F1DA4093;
        Tue, 29 Jun 2021 11:55:59 +0000 (GMT)
Received: from sig-9-65-193-149.ibm.com (unknown [9.65.193.149])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 11:55:59 +0000 (GMT)
Message-ID: <f316fc7329dadffd84a393e4e4d10d62f84e9712.camel@linux.ibm.com>
Subject: Re: [RFC] ima: check ima-policy's path
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianxing Zhang <anakinzhang96@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 29 Jun 2021 07:55:58 -0400
In-Reply-To: <20210629063843.18499-1-anakinzhang96@gmail.com>
References: <20210629063843.18499-1-anakinzhang96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xpRN1G-ZQJyQ56Li98QfrG30KWTCeaKF
X-Proofpoint-ORIG-GUID: HR2iejNDZPuJ6mzazSnyOVsqgGxtibt3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_06:2021-06-28,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290079
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-06-29 at 14:38 +0800, Tianxing Zhang wrote:
> Hi, I was reading the function ima_write_policy in ima/ima_fs.c when
> I find the issue:
> 
> > static ssize_t ima_write_policy(struct file *file, const char
> __user *buf,
> >                                              size_t datalen, loff_t
> *ppos)
> > {
> >         ...
> >
> >         if (data[0] == '/') {
> >                 result = ima_read_policy(data);
> >         } else if (ima_appraise & IMA_APPRAISE_POLICY) {
> >                 pr_err("signed policy file (specified as an
> absolute pathname) required\n");
> >                 integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
> NULL,
> >                                              "policy_update",
> "signed policy required",
> >                                              1, 0);
> >         ...
> >         return result;
> > }
> 
> For the absolute path written by the user, we only check the prefix
> "/". Actually, we can echo an illegal path to the
> /sys/kernel/security/ima/policy, e.g. "/\rtest: ddddddddddddddddddd"
> to inject some logs into dmesg.
> 
> Then ima_read_policy is called to return error:
> 
> > static ssize_t ima_read_policy(char *path)
> > {
> >         ...
> >         rc = kernel_read_file_from_path(path, 0, &data, INT_MAX,
> NULL,
> >                                                      
> READING_POLICY);
> >         if (rc < 0) {
> >                 pr_err("Unable to open file: %s (%d)", path, rc);
> >                 return rc;
> >         }
> >         ...
> > }
> 
> In ima_read_policy, the illegal path would be logged into dmesg like
> this:
> 
> > ...
> > test: ddddddddddddddddddd (-2)/
> > test: ddddddddddddddddddd (-2)/
> > test: ddddddddddddddddddd (-2)/
> > test: ddddddddddddddddddd (-2)/
> 
> I suggest that we should check the path in ima_write_policy to make
> sure it's a valid one, at least literally.

Sure.  In the case that the path isn't valid, perhaps instead of
removing the message entirely, limit the number of messages emitted
using pr_err_once().

thanks,

Mimi

