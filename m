Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9606D20E4E8
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2020 00:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbgF2VaW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 17:30:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728873AbgF2VaW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 17:30:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TL3oWa041064;
        Mon, 29 Jun 2020 17:30:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydk9e64q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 17:30:10 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TLTiJq191397;
        Mon, 29 Jun 2020 17:30:10 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydk9e63h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 17:30:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TLJIH4021282;
        Mon, 29 Jun 2020 21:30:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31wwr8atb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 21:30:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TLU51O55640508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 21:30:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A950A405D;
        Mon, 29 Jun 2020 21:30:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B4A3A4040;
        Mon, 29 Jun 2020 21:30:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.137.220])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jun 2020 21:30:03 +0000 (GMT)
Message-ID: <1593466203.5085.62.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Rename internal audit rule functions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-audit@redhat.com
Date:   Mon, 29 Jun 2020 17:30:03 -0400
In-Reply-To: <20200629153037.337349-1-tyhicks@linux.microsoft.com>
References: <20200629153037.337349-1-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=2 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 cotscore=-2147483648
 impostorscore=0 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290130
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing the audit mailing list]

On Mon, 2020-06-29 at 10:30 -0500, Tyler Hicks wrote:
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index ff2bf57ff0c7..5d62ee8319f4 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -419,24 +419,24 @@ static inline void ima_free_modsig(struct modsig *modsig)
>  /* LSM based policy rules require audit */
>  #ifdef CONFIG_IMA_LSM_RULES
>  
> -#define security_filter_rule_init security_audit_rule_init
> -#define security_filter_rule_free security_audit_rule_free
> -#define security_filter_rule_match security_audit_rule_match
> +#define ima_audit_rule_init security_audit_rule_init
> +#define ima_audit_rule_free security_audit_rule_free
> +#define ima_audit_rule_match security_audit_rule_match

Instead of defining an entirely new method of identifying files, IMA
piggybacks on top of the existing audit rule syntax.  IMA policy rules
"filter" based on this information.

IMA already audits security/integrity related events.  Using the word
"audit" here will make things even more confusing than they currently
are.  Renaming these functions as ima_audit_rule_XXX provides no
benefit.  At that point, IMA might as well call the
security_audit_rule prefixed function names directly.  As a quick fix,
rename them as "ima_filter_rule".

The correct solution would probably be to rename these prefixed
"security_audit_rule" functions as "security_filter_rule", so that
both the audit subsystem and IMA could use them.

Mimi
