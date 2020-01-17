Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7579114015F
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2020 02:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbgAQBRP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jan 2020 20:17:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbgAQBRP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jan 2020 20:17:15 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00H0vqtj137889
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 20:17:14 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qs3crr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 20:17:14 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 17 Jan 2020 01:17:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Jan 2020 01:17:09 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00H1H8Q153411874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 01:17:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2380211C050;
        Fri, 17 Jan 2020 01:17:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DC9711C04C;
        Fri, 17 Jan 2020 01:17:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.196.61])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jan 2020 01:17:07 +0000 (GMT)
Subject: Re: [PATCH v1] IMA: pre-allocate buffer to hold keyrings string
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jan 2020 20:17:06 -0500
In-Reply-To: <20200116234623.2959-1-nramas@linux.microsoft.com>
References: <20200116234623.2959-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011701-4275-0000-0000-0000039848C7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011701-4276-0000-0000-000038AC4906
Message-Id: <1579223826.5049.13.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_06:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=971
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170007
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

Trimming the Cc list. This patch is limited to IMA. 

On Thu, 2020-01-16 at 15:46 -0800, Lakshmi Ramasubramanian wrote:

>  
> @@ -949,6 +949,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  	bool uid_token;
>  	struct ima_template_desc *template_desc;
>  	int result = 0;
> +	size_t keyrings_len;
>  
>  	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
>  				       AUDIT_INTEGRITY_POLICY_RULE);
> @@ -1114,14 +1115,47 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  		case Opt_keyrings:
>  			ima_log_string(ab, "keyrings", args[0].from);
>  
> +			keyrings_len = strlen(args[0].from) + 1;
> +
>  			if ((entry->keyrings) ||
>  			    (entry->action != MEASURE) ||
> -			    (entry->func != KEY_CHECK)) {
> +			    (entry->func != KEY_CHECK) ||
> +			    (keyrings_len < 2)) {
>  				result = -EINVAL;
>  				break;
>  			}
> +
> +			if (ima_keyrings) {
> +				if (keyrings_len > ima_keyrings_len) {
> +					char *tmpbuf;
> +
> +					tmpbuf = krealloc(ima_keyrings,
> +							  keyrings_len,
> +							  GFP_KERNEL);
> +					if (!tmpbuf) {
> +						result = -ENOMEM;
> +						break;
> +					}
> +
> +					ima_keyrings = tmpbuf;
> +					ima_keyrings_len = keyrings_len;
> +				}
> +			} else {
> +				ima_keyrings = kzalloc(keyrings_len,
> +						       GFP_KERNEL);
> +				if (!ima_keyrings) {
> +					result = -ENOMEM;
> +					break;
> +				}
> +
> +				ima_keyrings_len = keyrings_len;
> +			}

The first time this code is executed ima_keyrings_len is 0.  So "if
(ima_keyrings_len < keyring_len)" will be true.  There's no reason to
differentiate between the first time or subsequent times this code is
executed.  In both cases, krealloc() can be used. 

Mimi


> +
>  			entry->keyrings = kstrdup(args[0].from, GFP_KERNEL);
>  			if (!entry->keyrings) {
> +				kfree(ima_keyrings);
> +				ima_keyrings = NULL;
> +				ima_keyrings_len = 0;
>  				result = -ENOMEM;
>  				break;
>  			}

