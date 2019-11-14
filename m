Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1455FFC90C
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 15:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfKNOiL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 09:38:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38762 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbfKNOiL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 09:38:11 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEEZSJQ034717
        for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2019 09:38:09 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w92jm3xdf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2019 09:38:06 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Nov 2019 14:37:24 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Nov 2019 14:37:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAEEbJpS39125238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 14:37:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 432A1AE045;
        Thu, 14 Nov 2019 14:37:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 073DFAE053;
        Thu, 14 Nov 2019 14:37:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.133.147])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Nov 2019 14:37:17 +0000 (GMT)
Subject: Re: [PATCH v7 4/5] IMA: Add support to limit measuring keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Nov 2019 09:37:17 -0500
In-Reply-To: <20191114031202.18012-5-nramas@linux.microsoft.com>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
         <20191114031202.18012-5-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111414-0008-0000-0000-0000032F0196
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111414-0009-0000-0000-00004A4E10BB
Message-Id: <1573742237.4793.30.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-13 at 19:12 -0800, Lakshmi Ramasubramanian wrote:
> +/**
> + * ima_match_keyring - determine whether the keyring matches the measure rule
> + * @rule: a pointer to a rule
> + * @keyring: name of the keyring to match against the measure rule
> + *
> + * If the measure action for KEY_CHECK does not specify keyrings=
> + * option then return true (Measure all keys).
> + * Else, return true if the given keyring name is present in
> + * the keyrings= option. False, otherwise.
> + */
> +static bool ima_match_keyring(struct ima_rule_entry *rule,
> +			      const char *keyring)
> +{
> +	if ((keyring == NULL) || (rule->keyrings == NULL)
> +		return true;

If the policy requires matching a specific keyring, then the "keyring"
needs to match.  The logic, here, isn't quite right.

> +	else
> +		return (strstr(rule->keyrings, keyring) != NULL);

    if (rule->keyrings) {
            if (!keyring)
                    return false;
		
            return (strstr(rule->keyrings, keyring) != NULL);
    }

    return true;

Keyrings may be created by userspace with any name (e.g. foo, foobar,
...).  A keyring name might be a subset of another keyring name.  For
example, with the policy "keyrings=foobar", keys being loaded on "foo"
would also be measured.  Using strstr() will not achieve what is
needed.

Mimi


> +}
> +
>  /**
>   * ima_match_rules - determine whether an inode matches the measure rule.
>   * @rule: a pointer to a rule
> @@ -364,18 +384,23 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>   * @secid: the secid of the task to be validated
>   * @func: LIM hook identifier
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
> + * @keyring: keyring name to check in policy for KEY_CHECK func
>   *
>   * Returns true on rule match, false on failure.
>   */
>  static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  			    const struct cred *cred, u32 secid,
> -			    enum ima_hooks func, int mask)
> +			    enum ima_hooks func, int mask,
> +			    const char *keyring)
>  {
>  	int i;
>  
>  	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
> -		if ((rule->flags & IMA_FUNC) && (rule->func == func))
> +		if ((rule->flags & IMA_FUNC) && (rule->func == func)) {
> +			if (func == KEY_CHECK)
> +				return ima_match_keyring(rule, keyring);
>  			return true;
> +		}
>  		return false;
>  	}
>  	if ((rule->flags & IMA_FUNC) &&

