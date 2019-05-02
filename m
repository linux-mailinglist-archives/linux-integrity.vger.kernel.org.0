Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3F12016
	for <lists+linux-integrity@lfdr.de>; Thu,  2 May 2019 18:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEBQ0i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 May 2019 12:26:38 -0400
Received: from sonic308-8.consmr.mail.bf2.yahoo.com ([74.6.130.47]:33911 "EHLO
        sonic308-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfEBQ0i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 May 2019 12:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1556814397; bh=4PgbqVnvHOQkUk3YG4PidmP1RHiYRTKxgvCKv2qGFds=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NlEn64f9wIy74YHwaX7rTyoZLz1CsP60rIouktR01XF/phcxjejrFpEyeT9lWPf/fV1EP8aXKwxBx6uNnJ58KN/1U9S2dXBpKCMiiMBTM+4T2y8vaRVt+PwmRLMXfjCPjLIOmaqKx7NYfBAnk2onWmepVdD2B8C5XFiuTAmJCY5h04ZK+eDUzlM6qqHHfWH7o86YKudh/5N+iyAxTGQ7jp7IFqk8rZIXCzy0GN73Ev/y8RL9SQW+tKCrViF7lL746c+sqn9kdfrOc8dTiouweqg5l7jn4IvLBrIJex+g1twLTBGdhghzc8jgCmdl1sGZuefsMVzxRlOGILsm2RFSiA==
X-YMail-OSG: v1ft5gMVM1kVZeTpHCyFvDoJ6nhxxeayX7D1x3kizyyCsuGnYX.uALbteJM6lzS
 X1gi51Qt8bQacimWdA9VvgwHHf4D5u.Pm6KEokoPLMdGI9FSlYyekFocVqUwoQrZG1U5.i1QW_qR
 Pe.ydTnqpI_EYa1sAYxhJMK0qZnuGdr_6IKHmG3Ch4OBeX0MRynJQdv4_iHBmgrlCoG1x087OOmG
 9Svy4nD8VCyAlrRvRr_sRITOettukAimLiOXgf2tkFLDJGPWE.Q40nS9trkoo61b_D5Qibg7Ocnu
 mGnr7vS5EI2sv5zpI81LF4sleXeS3EHX_2LQarviZfpqwZ6gGekavlqH6mXcC342AnKwSiS.tXL7
 DPpN_P6e4z.ybisQKyN4cyowL3ACXZkQXpQjTLftjjk_gumjj_fmdFpImlsHXfhkX8.fndVQ0W.k
 InDW.AvkYlzJ7HVbIDxaAG0iFnli9lp99rblsVyh5z1auqbhizyPmD7_6zeHt0.xOAiCWEJ4vmsn
 lwaluspgwfNkxU1WDSpdBlKqvL9YT.Wnuz2OO8mXROxPDaAM8aAOnEuIt3DPH6LjA9LZ0suDoOWL
 ODIxr2e40AStAo8A4O1bfxtWG3FJJZkHVf1Gad_Jql1ysoZbDJS10L3QIkKg2hHVTitS2MjsyHGn
 UST6VHDMXFCEdzsRRV6VkyNsZDmXoHRBWYD9jR7HF5rMb_x6rOBCoePPCnd.tIUSz4Vi5aRu.KkN
 O0ZTT4WPEyGExim0Kkp3b8DD9TY1EJwvUsUoU3BDznDhkSy8p7dQbwK5ACaDRVXix2xhIbKtN7Lm
 HFzoUMYqeCSA_8ZOxHnrREZg1TEyWfjZvoegIDgO2ez6J0zu1LGNNqRsmIwEQkHkpaGQ_HPACZNs
 D.Ig067Cs55LtsmgE7rDOexn4t_Uo36e9LcoAJ2PUwMQgPF47GEJXX_n1g94Pje5FbfaK6Eg2sVe
 mk1zmhfnFqaWgLkVnCrwWkGW8Bl.L7YMJwQsLKb7ewF342utHEk._xTHUM1i3PIStbHiw.6l73rq
 P2l.MxMvbE.CmZE6gW42Kn4vr9vZVDjLOz_zyKUt7bYqGvZKs6KSI9.kD6yY3_Y9EGLc.3bsPnsb
 19pWRYv4QIHeDuBFn7Md0kSFv7xODdGoeG2YKJDxztfPsAAxLhSHhf0ZDlnS0JCsEtfjaGg6oXen
 rnJsLBtlPipw_FlPL8sahzSy9DwCK_Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Thu, 2 May 2019 16:26:37 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp414.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c5863758f5d33a2aa8aed50d6f642b99;
          Thu, 02 May 2019 16:26:36 +0000 (UTC)
Subject: Re: [PATCH] kexec_buffer measure
To:     Mimi Zohar <zohar@linux.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        casey@schaufler-ca.com
References: <CAEFn8qKkXgxUKtribbtFwvG9NykGQo10jQ5Du_i9wJz-wKreOA@mail.gmail.com>
 <1555978681.4914.305.camel@linux.ibm.com>
 <1556812101.4134.28.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a30f7742-8368-be0c-4bab-28bcce0966aa@schaufler-ca.com>
Date:   Thu, 2 May 2019 09:26:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556812101.4134.28.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/2/2019 8:48 AM, Mimi Zohar wrote:
> [Cc'ing Paul, John, Casey]
>
> On Mon, 2019-04-22 at 20:18 -0400, Mimi Zohar wrote:
>> [Cc'ing LSM mailing list]
>>
>> On Fri, 2019-04-19 at 17:30 -0700, prakhar srivastava wrote:
>>
>>> 2) Adding a LSM hook
>>> We are doing both the command line and kernel version measurement in IMA.
>>> Can you please elaborate on how this can be used outside of the scenario?
>>> That will help me come back with a better design and code. I am
>>> neutral about this.
>> As I said previously, initially you might want to only measure the
>> kexec boot command line, but will you ever want to verify or audit log
>> the boot command line hash?????Perhaps LSMs would be interested in the
>> boot command line. ??Should this be an LSM hook?
>  From an LSM perspective, is there any interest in the boot command line?

I can imagine an LSM that cares about the command line,
but I have an interest in it for any work I have in progress.

>
> Mimi
>
