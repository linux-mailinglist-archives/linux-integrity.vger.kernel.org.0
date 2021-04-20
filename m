Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E6B366137
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Apr 2021 22:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhDTUy0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Apr 2021 16:54:26 -0400
Received: from gateway36.websitewelcome.com ([192.185.179.26]:20622 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234042AbhDTUyZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Apr 2021 16:54:25 -0400
X-Greylist: delayed 1471 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 16:54:25 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id A793241866A08
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 15:28:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ywyulm1UGPkftYwyulzrV9; Tue, 20 Apr 2021 15:28:24 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iAn70tR/fd1yZfaAabH+Y/BPcV703Uz3rtYuuggVBZs=; b=jF3UcFo7Dhq7RqiPQ4Jq1xsO1n
        kPff+Yzqk0rWnJqLut/DI+R7kd3gUPa0814W+JmABs4vHrHMCxukQMcL/BOGxRxeYLvETjcTan7Na
        kco1MwcKAjiSAU4ZC0LkTUqabv4jzTHOhmGmiOaZpLQFGFvnNT6ci2xm1M6biPvBzVJ4rg+eUtdc3
        DtFVRKkCUBQVLV20muE9JYfw2Pho/pDcmtnc/9Zw8XwYLZt6YUdMZJg79HjjprR06SoLmYs3Y/suh
        RjDL90g5SR4tcg/31JjU5P0Qt4cuOtK/kkL7hIP/RnsA6ZCQqnsjBcNVdiqqQ/Az8oWeKDjZ2zuIj
        4GRQLrqw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49074 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwyq-0039sF-PK; Tue, 20 Apr 2021 15:28:20 -0500
Subject: Re: [PATCH 010/141] ima: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <ae416f97079da13568026228d930e9e59118cc4c.1605896059.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <77650781-7088-21b7-aa8e-8e5fbf81920e@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:28:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ae416f97079da13568026228d930e9e59118cc4c.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYwyq-0039sF-PK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49074
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 214
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/20/20 12:25, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead of just
> letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  security/integrity/ima/ima_main.c   | 1 +
>  security/integrity/ima/ima_policy.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2d1af8899cab..600b97677085 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -743,6 +743,7 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
>  			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9b5adeaa47fc..ea634fc3b82f 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -566,6 +566,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
>  						   Audit_equal,
>  						   rule->lsm[i].rule);
> +			break;
>  		default:
>  			break;
>  		}
> @@ -802,6 +803,7 @@ void __init ima_init_policy(void)
>  		add_rules(default_measurement_rules,
>  			  ARRAY_SIZE(default_measurement_rules),
>  			  IMA_DEFAULT_POLICY);
> +		break;
>  	default:
>  		break;
>  	}
> 
