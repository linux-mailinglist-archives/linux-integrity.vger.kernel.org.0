Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9648E1F7D91
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2020 21:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFLTZb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 15:25:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726417AbgFLTZ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 15:25:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CIXtr5115011;
        Fri, 12 Jun 2020 15:25:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31m1vc0ptv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 15:25:26 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05CIg3gu142032;
        Fri, 12 Jun 2020 15:25:26 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31m1vc0pth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 15:25:26 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CJLhMt029152;
        Fri, 12 Jun 2020 19:25:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s83t5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 19:25:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05CJPMuI63373472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 19:25:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B6B652051;
        Fri, 12 Jun 2020 19:25:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.133.187])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3569F5204F;
        Fri, 12 Jun 2020 19:25:21 +0000 (GMT)
Message-ID: <1591989920.11061.90.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jun 2020 15:25:20 -0400
In-Reply-To: <20200611000400.3771-1-nramas@linux.microsoft.com>
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_23:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 cotscore=-2147483648 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-06-10 at 17:03 -0700, Lakshmi Ramasubramanian wrote:
> Error code is not included in the audit messages logged by
> the integrity subsystem. Add a new field namely "errno" in
> the audit message and set the value to the error code passed
> to integrity_audit_msg() in the "result" parameter.
> 
> Sample audit message:
> 
> [    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate cause=alloc_entry errno=-12 comm="swapper/0" name="boot_aggregate" res=0
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
---
>  security/integrity/integrity_audit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 5109173839cc..8cbf415bb977 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -42,7 +42,8 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>  			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
>  			 audit_get_sessionid(current));
>  	audit_log_task_context(ab);
> -	audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
> +	audit_log_format(ab, " op=%s cause=%s errno=%d comm=",
> +			 op, cause, result);

The idea is a good idea, but you're assuming that "result" is always
errno.  That was probably true originally, but isn't now.  For
example, ima_appraise_measurement() calls xattr_verify(), which
compares the security.ima hash with the calculated file hash.  On
failure, it returns the result of memcmp().  Each and every code path
will need to be checked.

>  	audit_log_untrustedstring(ab, get_task_comm(name, current));
>  	if (fname) {
>  		audit_log_format(ab, " name=");

