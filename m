Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E12225A16
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 10:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGTIdc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 04:33:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:60952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTIdc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 04:33:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92C28AE0D;
        Mon, 20 Jul 2020 08:33:37 +0000 (UTC)
Date:   Mon, 20 Jul 2020 10:33:30 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH 2/3] ima-evm-utils: output specific "unknown keyid" file
 msg based on log level
Message-ID: <20200720083330.GD11397@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
 <1595174524-4976-2-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595174524-4976-2-git-send-email-zohar@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> -		log_info("%s: verification failed: unknown keyid %x\n",
> -			 file, __be32_to_cpup(&keyid));
> +		if (imaevm_params.verbose > LOG_INFO)
> +			log_info("%s: verification failed: unknown keyid %x\n",

BTW, I was thinking to add more macros which would handle if
(imaevm_params.verbose > LOG_INFO), something like:

+#define log_dump_verbose(p, len)               if (imaevm_params.verbose > LOG_INFO) do_dump(p, len, true)
+#define log_verbose(fmt, args...)              if (imaevm_params.verbose > LOG_INFO) log_info(fmt, ##args)

But in the end I didn't post it, because:
1) imaevm_params.verbose is sometimes used for other purpose:
src/evmctl.c:
	if (sigdump || imaevm_params.verbose >= LOG_INFO)
		imaevm_hexdump(sig, len);
...
	if (imaevm_params.verbose > LOG_INFO) {
		log_info("%d ", entry->header.pcr);
		log_dump_n(entry->header.digest, sizeof(entry->header.digest));
		log_info(" %s %s", entry->name, algo);
		log_dump_n(digest, digest_len);
		log_info(" %s", path);
		if (fbuf) {
			log_info(" ");
			log_dump_n(fbuf, fbuf_len);
		}
	}
...
     if (imaevm_params.verbose <= LOG_INFO)
         return;

2) code sometimes compares: imaevm_params.verbose >= LOG_INFO (i.e. >= vs >; is
that intentional?)

Kind regards,
Petr
