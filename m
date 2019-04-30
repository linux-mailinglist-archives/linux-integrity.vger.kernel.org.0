Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99961102F6
	for <lists+linux-integrity@lfdr.de>; Wed,  1 May 2019 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfD3XAl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Apr 2019 19:00:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49118 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfD3XAl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Apr 2019 19:00:41 -0400
Received: from [10.91.6.157] (unknown [131.107.159.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id DAB363022B4F;
        Tue, 30 Apr 2019 16:00:40 -0700 (PDT)
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
 <93b9433f-cc99-c1fe-f7d1-bc8d26fd4dc1@linux.microsoft.com>
 <CACdnJuvpe6_O8jPb-2pBPqgAZ7J1NbuPvbOO4kDd4d80k8p8OA@mail.gmail.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <0dc4e73c-00a8-5023-7065-3b21483a8a14@linux.microsoft.com>
Date:   Tue, 30 Apr 2019 16:00:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACdnJuvpe6_O8jPb-2pBPqgAZ7J1NbuPvbOO4kDd4d80k8p8OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/30/19 3:43 PM, Matthew Garrett wrote:
> On Tue, Apr 30, 2019 at 9:28 AM Jordan Hand <jorhand@linux.microsoft.com> wrote:
> 
>> 1st Gen (SKU Number from dmidecode is LENOVO_MT_3448)
> 
> Ok, unfortunately not able to grab one of those. If you boot with
> earlyprintk=efi on the kernel command line, do you get any output
> around the hang?
> 
No. The only print messages I get are from efi_printk. And they don't 
show up like normal kernel logs do during boot. The purple grub screen 
hangs and the efi_printk messages just print over the top of it.

Although now I'm wondering if the efi_printk messages I added after 
efi_exit_boot_services just aren't showing up because I've exited boot 
services and can no longer call that function (seems reasonable).
