Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A251810EF96
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 19:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfLBSz0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 13:55:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfLBSz0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 13:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575312924;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BasR9fJysMtCMWPHS/Ez/vs7HdvrZKVU0mKfLNeG6GU=;
        b=dpI4pbHIbjLbAku77fMihwS7fa9tD16OCWLd5hTrhlaR/vaqNxv3oW8nRXb75Lc1uT0zwz
        DNr/QHtKyXmrJTZGTtaGQpQsWFvFTfQAzW/USiMzbh4/bpkT5fdghNip9KL6hegzakOwPV
        eEVftbkIpAlK0YKkdj8PYCGWWUh89H4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-YFBcssruN8Wf9aB6uqfbuA-1; Mon, 02 Dec 2019 13:55:23 -0500
Received: by mail-pg1-f197.google.com with SMTP id r30so232109pgm.8
        for <linux-integrity@vger.kernel.org>; Mon, 02 Dec 2019 10:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3tYGvKckyNK6guzJmLUsGmhSZAtdLju3TCYhP65wmYk=;
        b=WomjzqWnN4C20i/Okk/2maz6wwYXwD0WYBkZAlS/xg57y5yhKOGfoGaHBIaaMEicTt
         j5jks6PHOf64rZ5DNK3xQE6foad8sQPANP8KYsXCaCyPkAj1gP2glzpNiQi/DaPz/83M
         pT+BCsRkZhSUR0O4664C89ZmvhMeFOEnikb03l2laGCWaUpdJzECN1BCabLCV3vP6ZSo
         c3k8wtjOTIbpE3lvbnRWvjE9qd8hICPYBc3540m7Z+dRKuj6lfKlof7zJy765ucIdXpX
         igvMFcaNA2Y11gmj9XGoH/LUG4HN3jQZuCyWBUH0UrFNMwBS08EEgKc9AzHuM9IEOTaG
         3Dsw==
X-Gm-Message-State: APjAAAXkkCP0JnyQfsOG+rIC1JN+s8Zl/CvuqffxgTk7P4ZHWIZP0qpH
        PzAIL5HXyPPFk3rbraxQmkMGQpefj2BuhXJ2PHDQaKWhCcsG84FIqsoZzEQnxvzS9nojFa3o0T1
        4NwnaiZMA+czTrLE8/naaaGdvMy3w
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr631791plv.331.1575312922277;
        Mon, 02 Dec 2019 10:55:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqx10URV1PHP5Yt2PPgF5JNaFQDDTv65xxiVu8l3E0jlcc9g5YQ3pGK9NLzlsY1cV2dHkq7eDg==
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr631768plv.331.1575312921957;
        Mon, 02 Dec 2019 10:55:21 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d85sm203111pfd.146.2019.12.02.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:55:21 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:55:20 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] Revert patches fixing probing of interrupts
Message-ID: <20191202185520.57w2h3dgs5q7lhob@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20191126131753.3424363-1-stefanb@linux.vnet.ibm.com>
 <20191129223418.GA15726@linux.intel.com>
 <6f6f60a2-3b55-e76d-c11a-4677fcb72c16@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <6f6f60a2-3b55-e76d-c11a-4677fcb72c16@linux.ibm.com>
X-MC-Unique: YFBcssruN8Wf9aB6uqfbuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun Dec 01 19, Stefan Berger wrote:
>On 11/29/19 5:37 PM, Jarkko Sakkinen wrote:
>>On Tue, Nov 26, 2019 at 08:17:51AM -0500, Stefan Berger wrote:
>>>From: Stefan Berger <stefanb@linux.ibm.com>
>>>
>>>Revert the patches that were fixing the probing of interrupts due
>>>to reports of interrupt stroms on some systems
>>Can you explain how reverting is going to fix the issue?
>
>
>The reverts fix 'the interrupt storm issue' that they are causing on=20
>some systems but don't fix the issue with the interrupt mode not being=20
>used. I was hoping Jerry would get access to a system faster but this=20
>didn't seem to be the case. So sending these patches seemed the better=20
>solution than leaving 5.4.x with the problem but going back to when it=20
>worked 'better.'
>

I finally heard back from IT support, and unfortunately they don't
have any T490s systems to give out on temp loan. So I can only send
patched kernels to the end user that had the problem.

>
>>
>>This is wrong way to move forward. The root cause must be identified
>>first and then decide actions like always in any situation.
>>
>>/Jarkko
>
>

