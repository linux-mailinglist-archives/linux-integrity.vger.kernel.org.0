Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4CFE27B1
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 03:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfJXB1u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 21:27:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60460 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXB1t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 21:27:49 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3E7BA20F3BC1;
        Wed, 23 Oct 2019 18:27:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E7BA20F3BC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571880469;
        bh=7uKBvl8yiufQLf7daeVfbHD8ZvcsSsW7/pDpL5qUKm8=;
        h=To:From:Subject:Date:From;
        b=pN66PVcxLf8AGC9pt2mSBUkcm2fakbOHtiuJrGyMMAURTqR2FGmtu6AIZBIYAhzuZ
         gXkXFJrz+UBd5vcOJ7wVSlCCNVDIM7gQMUqLg/kSEGzvO3zTD6wgh3cmQt40sebcXI
         r9OCTCnPadqXFmMKr8/2uUNa9l6MV4vHFdypw820=
To:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Measure ima policy
Message-ID: <81e4a3f1-146b-cad2-a868-24a38cfde599@linux.microsoft.com>
Date:   Wed, 23 Oct 2019 18:27:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

Do you know if there is a plan (or, work already in progress) to measure 
the "ima policy" that is currently in effect?

We were thinking it would be a good measurement to have that an 
attestation service can validate.

thanks,
  -lakshmi
