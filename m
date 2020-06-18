Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E81FFA75
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbgFRRls (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 13:41:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729612AbgFRRlq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 13:41:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IH2B43004775;
        Thu, 18 Jun 2020 13:41:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31r560g2n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 13:41:44 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05IHAnhV036160;
        Thu, 18 Jun 2020 13:41:43 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31r560g2m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 13:41:43 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05IHdpFs029860;
        Thu, 18 Jun 2020 17:41:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31quax9fk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 17:41:40 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05IHfbrE59703556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 17:41:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33C3CA405B;
        Thu, 18 Jun 2020 17:41:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23E07A4054;
        Thu, 18 Jun 2020 17:41:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.230.246])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jun 2020 17:41:36 +0000 (GMT)
Message-ID: <1592502095.4615.42.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] integrity: Add errno field in audit message
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, nayna@linux.ibm.com, sgrubb@redhat.com,
        paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Date:   Thu, 18 Jun 2020 13:41:35 -0400
In-Reply-To: <20200617204436.2226-2-nramas@linux.microsoft.com>
References: <20200617204436.2226-1-nramas@linux.microsoft.com>
         <20200617204436.2226-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_14:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-06-17 at 13:44 -0700, Lakshmi Ramasubramanian wrote:
> Error code is not included in the audit messages logged by
> the integrity subsystem. Add "errno" field in the audit messages
> logged by the integrity subsystem and set the value to the error code
> passed to integrity_audit_msg() in the "result" parameter.
> 
> Sample audit messages:
> 
> [    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate cause=alloc_entry comm="swapper/0" name="boot_aggregate" res=0 errno=-12
> 
> [    8.085456] audit: type=1802 audit(1592005947.297:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=policy_update cause=completed comm="systemd" res=1 errno=0
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  security/integrity/integrity_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 5109173839cc..a265024f82f3 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -53,6 +53,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>  		audit_log_untrustedstring(ab, inode->i_sb->s_id);
>  		audit_log_format(ab, " ino=%lu", inode->i_ino);
>  	}
> -	audit_log_format(ab, " res=%d", !result);
> +	audit_log_format(ab, " res=%d errno=%d", !result, result);
>  	audit_log_end(ab);
>  }

For the reasons that I mentioned previously, unless others are willing
to add their Reviewed-by tag not for the audit aspect in particular,
but IMA itself, I'm not comfortable making this change all at once.

Previously I suggested making the existing integrity_audit_msg() a
wrapper for a new function with errno.  Steve said, "We normally do
not like to have fields that swing in and out ...", but said setting
errno to 0 is fine.  The original integrity_audit_msg() function would
call the new function with errno set to 0.

Mimi
