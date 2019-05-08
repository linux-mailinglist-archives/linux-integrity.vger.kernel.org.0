Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA217CA2
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2019 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfEHOyS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 May 2019 10:54:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbfEHOyS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 May 2019 10:54:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 540ACACE1;
        Wed,  8 May 2019 14:54:17 +0000 (UTC)
Subject: Re: setfattr to set security.ima fails with error "Invalid argument"
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>
References: <b1107806-26b5-4518-724f-9aab0b86668b@linux.microsoft.com>
From:   Ignaz Forster <iforster@suse.de>
Message-ID: <0f7ed36d-8d8c-8a2a-189f-1c45b22652c2@suse.de>
Date:   Wed, 8 May 2019 16:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b1107806-26b5-4518-724f-9aab0b86668b@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am 03.05.19 um 23:59 Uhr schrieb Lakshmi Ramasubramanian:
> When trying to set security.ima extended attribute on any file I get 
> error "Invalid argument".
> 
> setfattr -n security.ima -v foo /boot/vmlinuz-4.18.0-17-generic
> setfattr: /boot/vmlinuz-4.18.0-17-generic: Invalid argument

"foo" is not a valid value.
If you just want to test setting *any* value you may try 
"0sBAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxg==".

> If I try any other name for the extended, say, foo I see error 
> "Operation not supported".
> 
> setfattr -n foo -v bar /boot/vmlinuz-4.18.0-17-generic
> setfattr: /boot/vmlinuz-4.18.0-17-generic: Operation not supported

You need to use a namespace, see `man 7 xattr` for more information 
about extended attributes.

Ignaz
