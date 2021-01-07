Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673C22ED6C4
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 19:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbhAGSgS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 13:36:18 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45716 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAGSgS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 13:36:18 -0500
Received: from [192.168.1.13] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id F0B4820B7192;
        Thu,  7 Jan 2021 10:35:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0B4820B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610044537;
        bh=B3Ku/Kb0mK2/t9Kta0731LdWDJYESKgP1mrsbZE08tQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cKWadn8i8xkOQPP65KHghZDVt2J3HyRMQKsf6VYXQ5+J2os17oXDv//wJEGygzF0E
         FBpucdkoU2tsGmGNTFPL+3iEraQfk4aG23mvvHcHHEpDKOoNXgu6FhEy3VhK4jVIMQ
         l/XZUN/3uY+038R+22jYynjFXrGe2xvKsEgaXYCI=
Subject: Re: [RFC] Persist ima logs to disk
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        balajib@linux.microsoft.com
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
 <CAE=NcrY7oecVUtoGd2Jwzb6wi3i11zFPrYj3u84w9eCdOyTi4Q@mail.gmail.com>
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
Message-ID: <206700a4-3187-1cf8-b23e-f3f859ce0b5d@linux.microsoft.com>
Date:   Thu, 7 Jan 2021 10:35:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAE=NcrY7oecVUtoGd2Jwzb6wi3i11zFPrYj3u84w9eCdOyTi4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/7/2021 7:45 AM, Janne Karhunen wrote:
> On Tue, Jan 5, 2021 at 9:57 PM Raphael Gianotti
> <raphgi@linux.microsoft.com> wrote:
>
>> In a thread with Janne Karhunen[2], it was mentioned that another
>> approach, using mm had been considered. Upon some investigation the
>> approach used in this RFC still seemed adequate for solving this
>> problem.
> Curious to hear in more detail where did this land?
>
> Not sure I remember this correctly anymore, but wouldn't it be
> possible to have mmap'd tmpfile at address __heap of size __heap_sz
> and have something this simple pulling memory from it?
>
> uint8_t *get_static_buffer(size_t size)
> {
>          static size_t buf_index;
>          uint8_t *bufp = NULL;
>
>          size = ROUND_UP(size, sizeof(double));
>          if ((buf_index + size) >= __heap_sz)
>                  return NULL;
>
>          bufp = (uint8_t *)__heap + buf_index;
>          buf_index += size;
>          *bufp = 0;
>
>          return bufp;
> }
>
> Then just replace every related measurement list allocation with this
> get_static_buffer and that would be pretty much all there is to it?
>
> The mm code should automatically push those pages out when it needs
> memory. It will also read those pages back in when someone scans
> through the measurement list creating a nicely formatted one. I think.
>
>
> --
> Janne
As I replied to the other comment from Mimi, I think I may have been 
overcomplicating
it. My knowledge of mm is still not very deep, so I may have overthought 
some parts of
it and thought anything I was coming up with didn't seem like a good way 
to do it. I will
revisit this, especially since I wasn't aware of the PCR concerns Mimi 
had, which make
sense and will probably be hard to solve with the code I just sent.

Raph

