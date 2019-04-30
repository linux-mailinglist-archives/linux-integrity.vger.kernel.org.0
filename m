Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4EAFDD8
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2019 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfD3Q2P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Apr 2019 12:28:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58816 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3Q2P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Apr 2019 12:28:15 -0400
Received: from [10.91.6.157] (unknown [131.107.159.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id B43843022B4E;
        Tue, 30 Apr 2019 09:28:14 -0700 (PDT)
Subject: Re: linux-tpmdd self signed kernel failing to boot with secreboot on
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
 <CACdnJuuhiQQ8Uq1A_qfidCLVPVQ_3Ty_Kqg+tQPDx2z3P0Yp9w@mail.gmail.com>
 <6373c67f-ea2f-ae1d-0343-4bb774f1d52f@linux.microsoft.com>
 <CACdnJusXEq=7LXB=Ry0zH4CTRkQLHPC+5DnP07yXi0TNPeCYTw@mail.gmail.com>
 <b4f9cc9d-bded-fb0a-1d53-40fa1460ddec@linux.microsoft.com>
 <CACdnJuuK=BqaHLDFU0+zXk539gobvaJFUpHuNL7nYZcpw8E0ZA@mail.gmail.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <93b9433f-cc99-c1fe-f7d1-bc8d26fd4dc1@linux.microsoft.com>
Date:   Tue, 30 Apr 2019 09:28:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACdnJuuK=BqaHLDFU0+zXk539gobvaJFUpHuNL7nYZcpw8E0ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/29/19 3:50 PM, Matthew Garrett wrote:
> On Mon, Apr 29, 2019 at 1:35 PM Jordan Hand <jorhand@linux.microsoft.com> wrote:
>> I have tried this both on a Gen2 Hyper-V VM (from a Windows Host) and on
>> a Lenovo X1 Carbon with the same results.
> 
> Can you let me know which generation of X1 it is? I'll see if I can
> borrow one to test. >

1st Gen (SKU Number from dmidecode is LENOVO_MT_3448)
