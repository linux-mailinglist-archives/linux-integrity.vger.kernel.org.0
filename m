Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD43F82E0
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 23:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKKW35 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 17:29:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50332 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKW35 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 17:29:57 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 903CE20B7192;
        Mon, 11 Nov 2019 14:29:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 903CE20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573511396;
        bh=Lx7iits91CkNuBqZLd20zMr4uyVVjAzL/Xch/h41f5Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nWiO84SaocrRuLAxT31uph/FEZblHnCD1LrQAYf0Tp8VnZJqcP2IoqCFkHPAdKThU
         PcbK2c9WbUxPfU+KRBQvDod7ake+pF2Aa43G0HOMQX7FhJgWfjNmiq+IymA9/gj+Rz
         bn+ePz+A16Hl+1yd1mENR6WKby+RQmdceiaZ6DnM=
Subject: Re: [PATCH] ima: avoid appraise error for hash calc interrupt
To:     Patrick Callaghan <patrickc@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20191111192348.30535-1-patrickc@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <e3f520ce-a290-206d-8097-b852123357ca@linux.microsoft.com>
Date:   Mon, 11 Nov 2019 14:29:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111192348.30535-1-patrickc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/11/19 11:23 AM, Patrick Callaghan wrote:

> -		if (rbuf_len == 0)
> +		if (rbuf_len == 0) {	/* unexpected EOF */
> +			rc = -EINVAL;
>   			break;
> +		}
>   		offset += rbuf_len;

Should there be an additional check to validate that (offset + rbuf_len) 
is less than i_size before calling cypto_shash_update (since rbuf_len is 
one of the parameters for this call)?

                if ((rbuf_len == 0) || (offset + rbuf_len >= i_size)) {
                         rc = -EINVAL;
                         break;
                }
                offset += rbuf_len;

>   	       rc = crypto_shash_update(shash, rbuf, rbuf_len);

  -lakshmi

