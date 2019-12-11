Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8E211A104
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 03:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLKCFy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 21:05:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47122 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfLKCFx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 21:05:53 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id DF50020B7187;
        Tue, 10 Dec 2019 18:05:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF50020B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576029952;
        bh=hYVcj/dykYtIKrC4mHeR6NMTwy9E6mgahHI6F3vE0AM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m4itgTn/YO1CwtOdnn6rEu/FzTJbyMvHuIZBIFmWygyw732Tlk4nnI+RhgGIZCLtZ
         o6JFYPgCtARgr4GG4wh7Za4/nvAZUngGA/C+G8/v+SFRRsp629sOo3IjBgNYP/WHgQ
         G4kf5OMpYsB5P1MObMQSe9CHP73VdpXOA55h8g4c=
Subject: Re: forever growing ima measurement list
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Elaine R Palmer <erpalmer@us.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        David Safford <david.safford@ge.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
References: <CAE=Ncrb-kMDRgALnvXtKukSVLEw81rqxGv6+XXxg487Q_qLKGA@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f48371ec-3754-05b8-3b31-da6842f9d486@linux.microsoft.com>
Date:   Tue, 10 Dec 2019 18:05:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAE=Ncrb-kMDRgALnvXtKukSVLEw81rqxGv6+XXxg487Q_qLKGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/10/19 3:38 AM, Janne Karhunen wrote:

Hi Janne,

> 
> Now, we can attempt to tackle this if there is a common agreement on
> what to do with the case. First thing that comes to my mind based on a
> comment from Mimi concerning the prior work on the topic by Dave is
> that the measurement list should probably get periodically exported to
> a file with its own measurement. Rest of the measurement entries would
> then get freed, so the system would start again from a clean state
> (ie. state where there is only 1 entry in the measurement list, the
> older generation list name and the measurement). For remote
> attestation of the system you would have to concatenate all the lists
> and verify their validity by walking down the chain, starting from the
> existing in-kernel measurement that is kept secure. In other words,
> each exported list would have a measurement of the earlier generation
> list and we would build a simple list chain.

Do we need to keep multiple on-disk lists? Can the measurement entries 
be written to one on-disk file - say, when the current in-memory buffer 
reaches a certain threshold?

A remote attestation of the system would then read the on-disk file and 
the current in-memory buffer to perform the validation.

I am assuming one of the reasons for keeping the measurement list in 
memory is for better performance. If buffered file I/O is supported in 
Linux, can that be leveraged for improved file I/O performance?

https://docs.microsoft.com/en-us/windows/win32/fileio/file-caching

thanks,
  -lakshmi


