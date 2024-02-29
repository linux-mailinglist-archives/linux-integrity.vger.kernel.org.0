Return-Path: <linux-integrity+bounces-1527-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC586D5BF
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 22:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACF528E89E
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 21:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E30151CCB;
	Thu, 29 Feb 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acRB86DB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94D151CC7
	for <linux-integrity@vger.kernel.org>; Thu, 29 Feb 2024 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240327; cv=none; b=HZtvYSs7RV8+XUDQCjoT5iO0/tNs2OSsUHAitekd1+CKDJNOJ9m9o5oospvtXxhCx/CeCoKei8CqH3BFHm8yVKHdQWcJ1WKz0guWD+Y4NHnYJd0xOQSMU5EX/GKMCkmSGWmuJr9AR01DYW5rfH1ehNj+SOEx5n2NHgh3gAHeUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240327; c=relaxed/simple;
	bh=KK2JYjsEotAYC4m0NxCFv//2rVgZdFac7SF2FuzcHm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ng8ZCu5/hVhecAaOQu3wiaUbdngxL548PQhnyGOvna+hk8eS+pk+KlUPwDQM0aYlcfC5adreTVCq7Z94T35Nk5Pq50UV3TLd1Zew32N2hxTD8albFlWF2Si7fKh54qDo5PfHeDwsxEZtheyR1zZ+i4RiPTyWpn+4mWhg3yVvJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acRB86DB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709240323;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afeyUsdTH/PHRfWkOYJYWMsh6t/9skAp5eQczkY4pA4=;
	b=acRB86DBuBKCywgnBMBLwdhmumJk22xaEcfwItP+mN5y+Uk42XYQ7KWCY7ZrjRweA800PP
	sFZWTWOyXJsNZ4TtjOcZLDN87IiNPv5HUXojyJ9Bks/LalE2pxure6FfnaGbV739xRMu3o
	qOq/yFJNtTJEb9CHpc90fkfxhDIoT5Y=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-gP7IdC4XPYO2arB6BWwEAQ-1; Thu, 29 Feb 2024 15:58:41 -0500
X-MC-Unique: gP7IdC4XPYO2arB6BWwEAQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-598b795e5b4so2079236eaf.3
        for <linux-integrity@vger.kernel.org>; Thu, 29 Feb 2024 12:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240321; x=1709845121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afeyUsdTH/PHRfWkOYJYWMsh6t/9skAp5eQczkY4pA4=;
        b=Zp3BK6P3SsENNHoEcSQCKt6F9p9+gJmo69ItRb5Eb1gvZTCMCJMzYaQ/3DtvfIbRPQ
         ZlzLyzTtiV/OnnTZ8w8mQqgCC0yK7D9mIUfopDlLdtp+2k6lkJVbd1+O0FzqLygKos4y
         AD2itDDYsm08/+GssqukXnBc6L7KZi8BeXopwhoQQtiU91eDX6emQUqYgF3kJhybD0aE
         CORIzJMOZAb5oy41t16Z8PCWjRBvkiMj6MrmgDNZPkG/VEY4/e5R+C2rkQi6332iXcON
         I7MWhLSQAs5VpzjKm8RQUT7UAlrwE4UnIsykrzz8c5nZSVxI2lFbBXfXK+gK3xweOncy
         wbUg==
X-Forwarded-Encrypted: i=1; AJvYcCUPFsTm8vGPqfenwVxOXpUr6NItjODK6VQaRd7Oe56GdHzR1gyFrii1kUCerhuymtDWQuEqvLNzZtVyuDxuTSGlzgycC7mupfQM+DUpYW89
X-Gm-Message-State: AOJu0YxnLV/uCfPU0PvKhJL6TVTnrndMaaotNBlS+DJs7pMIveQsZHzC
	PSgaevrttRRq514ss0bWoLNvUERBC15MPVp1X7rzfXy4e61n66O5n+Q5Baz8of3xPboNf+njZBf
	LgZrQ4wQUtlr+wp4r/K8tTL+/d4FplMEnsSGs0o7uUa6T8eHZU6QbfoJOhYZDH3tt0g==
X-Received: by 2002:a05:6871:8807:b0:21e:c176:9642 with SMTP id te7-20020a056871880700b0021ec1769642mr3919649oab.29.1709240320358;
        Thu, 29 Feb 2024 12:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUv640+gdvw7CKVLPuy/HK6t9IX33RLpMhk/8ZwKoixZ/7qGOFUtEFvMaN0rUurYTOnR6Xjw==
X-Received: by 2002:a05:6871:8807:b0:21e:c176:9642 with SMTP id te7-20020a056871880700b0021ec1769642mr3919607oab.29.1709240319640;
        Thu, 29 Feb 2024 12:58:39 -0800 (PST)
Received: from [172.16.0.69] (c-67-184-72-25.hsd1.il.comcast.net. [67.184.72.25])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a0b8100b00787c7c0a078sm1026131qkh.121.2024.02.29.12.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:58:38 -0800 (PST)
Message-ID: <0d3068a7-e555-452e-860c-6598e3c86fb3@redhat.com>
Date: Thu, 29 Feb 2024 14:58:36 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-integrity@vger.kernel.org
Cc: a.mardegan@omp.ru, git@andred.net, dbaryshkov@gmail.com,
 ebiggers@google.com, gcwilson@linux.ibm.com,
 James.Bottomley@HansenPartnership.com, kgoldman@us.ibm.com,
 mjg59@srcf.ucam.org, zohar@linux.ibm.com, patrick.ohly@intel.com,
 patrick@puiterwijk.org, petr.vorel@gmail.com, roberto.sassu@huawei.com,
 stefanb@linux.ibm.com, stephen.smalley.work@gmail.com,
 tianjia.zhang@linux.alibaba.com, vt@altlinux.org, vgoyal@redhat.com,
 z.jasinski@samsung.com
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
Content-Language: en-US
From: Frank Sorenson <sorenson@redhat.com>
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/21/24 03:28, Dmitry Kasatkin wrote:
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
>
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
>
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
>
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>

Acked-by: Frank Sorenson <sorenson@redhat.com>



> ---
>   COPYING                | 339 -----------------------------------------
>   LICENSES.txt           |  13 ++
>   src/evmctl.c           |  25 +--
>   src/hash_info.gen      |  10 +-
>   src/imaevm.h           |  25 +--
>   src/libimaevm.c        |  25 +--
>   src/pcr.h              |   2 +
>   src/pcr_ibmtss.c       |   2 +-
>   src/pcr_tss.c          |  25 +--
>   src/pcr_tsspcrread.c   |  25 +--
>   src/utils.c            |   2 +-
>   src/utils.h            |   2 +
>   tests/functions.sh     |  11 +-
>   tests/gen-keys.sh      |  11 +-
>   tests/ima_hash.test    |  11 +-
>   tests/sign_verify.test |  11 +-
>   tests/test_mmap.c      |   2 +-
>   17 files changed, 30 insertions(+), 511 deletions(-)
>   delete mode 100644 COPYING
>   create mode 100644 LICENSES.txt
>
> diff --git a/COPYING b/COPYING
> deleted file mode 100644
> index d159169..0000000
> --- a/COPYING
> +++ /dev/null
> @@ -1,339 +0,0 @@
> -                    GNU GENERAL PUBLIC LICENSE
> -                       Version 2, June 1991
> -
> - Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
> - 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - Everyone is permitted to copy and distribute verbatim copies
> - of this license document, but changing it is not allowed.
> -
> -                            Preamble
> -
> -  The licenses for most software are designed to take away your
> -freedom to share and change it.  By contrast, the GNU General Public
> -License is intended to guarantee your freedom to share and change free
> -software--to make sure the software is free for all its users.  This
> -General Public License applies to most of the Free Software
> -Foundation's software and to any other program whose authors commit to
> -using it.  (Some other Free Software Foundation software is covered by
> -the GNU Lesser General Public License instead.)  You can apply it to
> -your programs, too.
> -
> -  When we speak of free software, we are referring to freedom, not
> -price.  Our General Public Licenses are designed to make sure that you
> -have the freedom to distribute copies of free software (and charge for
> -this service if you wish), that you receive source code or can get it
> -if you want it, that you can change the software or use pieces of it
> -in new free programs; and that you know you can do these things.
> -
> -  To protect your rights, we need to make restrictions that forbid
> -anyone to deny you these rights or to ask you to surrender the rights.
> -These restrictions translate to certain responsibilities for you if you
> -distribute copies of the software, or if you modify it.
> -
> -  For example, if you distribute copies of such a program, whether
> -gratis or for a fee, you must give the recipients all the rights that
> -you have.  You must make sure that they, too, receive or can get the
> -source code.  And you must show them these terms so they know their
> -rights.
> -
> -  We protect your rights with two steps: (1) copyright the software, and
> -(2) offer you this license which gives you legal permission to copy,
> -distribute and/or modify the software.
> -
> -  Also, for each author's protection and ours, we want to make certain
> -that everyone understands that there is no warranty for this free
> -software.  If the software is modified by someone else and passed on, we
> -want its recipients to know that what they have is not the original, so
> -that any problems introduced by others will not reflect on the original
> -authors' reputations.
> -
> -  Finally, any free program is threatened constantly by software
> -patents.  We wish to avoid the danger that redistributors of a free
> -program will individually obtain patent licenses, in effect making the
> -program proprietary.  To prevent this, we have made it clear that any
> -patent must be licensed for everyone's free use or not licensed at all.
> -
> -  The precise terms and conditions for copying, distribution and
> -modification follow.
> -
> -                    GNU GENERAL PUBLIC LICENSE
> -   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
> -
> -  0. This License applies to any program or other work which contains
> -a notice placed by the copyright holder saying it may be distributed
> -under the terms of this General Public License.  The "Program", below,
> -refers to any such program or work, and a "work based on the Program"
> -means either the Program or any derivative work under copyright law:
> -that is to say, a work containing the Program or a portion of it,
> -either verbatim or with modifications and/or translated into another
> -language.  (Hereinafter, translation is included without limitation in
> -the term "modification".)  Each licensee is addressed as "you".
> -
> -Activities other than copying, distribution and modification are not
> -covered by this License; they are outside its scope.  The act of
> -running the Program is not restricted, and the output from the Program
> -is covered only if its contents constitute a work based on the
> -Program (independent of having been made by running the Program).
> -Whether that is true depends on what the Program does.
> -
> -  1. You may copy and distribute verbatim copies of the Program's
> -source code as you receive it, in any medium, provided that you
> -conspicuously and appropriately publish on each copy an appropriate
> -copyright notice and disclaimer of warranty; keep intact all the
> -notices that refer to this License and to the absence of any warranty;
> -and give any other recipients of the Program a copy of this License
> -along with the Program.
> -
> -You may charge a fee for the physical act of transferring a copy, and
> -you may at your option offer warranty protection in exchange for a fee.
> -
> -  2. You may modify your copy or copies of the Program or any portion
> -of it, thus forming a work based on the Program, and copy and
> -distribute such modifications or work under the terms of Section 1
> -above, provided that you also meet all of these conditions:
> -
> -    a) You must cause the modified files to carry prominent notices
> -    stating that you changed the files and the date of any change.
> -
> -    b) You must cause any work that you distribute or publish, that in
> -    whole or in part contains or is derived from the Program or any
> -    part thereof, to be licensed as a whole at no charge to all third
> -    parties under the terms of this License.
> -
> -    c) If the modified program normally reads commands interactively
> -    when run, you must cause it, when started running for such
> -    interactive use in the most ordinary way, to print or display an
> -    announcement including an appropriate copyright notice and a
> -    notice that there is no warranty (or else, saying that you provide
> -    a warranty) and that users may redistribute the program under
> -    these conditions, and telling the user how to view a copy of this
> -    License.  (Exception: if the Program itself is interactive but
> -    does not normally print such an announcement, your work based on
> -    the Program is not required to print an announcement.)
> -
> -These requirements apply to the modified work as a whole.  If
> -identifiable sections of that work are not derived from the Program,
> -and can be reasonably considered independent and separate works in
> -themselves, then this License, and its terms, do not apply to those
> -sections when you distribute them as separate works.  But when you
> -distribute the same sections as part of a whole which is a work based
> -on the Program, the distribution of the whole must be on the terms of
> -this License, whose permissions for other licensees extend to the
> -entire whole, and thus to each and every part regardless of who wrote it.
> -
> -Thus, it is not the intent of this section to claim rights or contest
> -your rights to work written entirely by you; rather, the intent is to
> -exercise the right to control the distribution of derivative or
> -collective works based on the Program.
> -
> -In addition, mere aggregation of another work not based on the Program
> -with the Program (or with a work based on the Program) on a volume of
> -a storage or distribution medium does not bring the other work under
> -the scope of this License.
> -
> -  3. You may copy and distribute the Program (or a work based on it,
> -under Section 2) in object code or executable form under the terms of
> -Sections 1 and 2 above provided that you also do one of the following:
> -
> -    a) Accompany it with the complete corresponding machine-readable
> -    source code, which must be distributed under the terms of Sections
> -    1 and 2 above on a medium customarily used for software interchange; or,
> -
> -    b) Accompany it with a written offer, valid for at least three
> -    years, to give any third party, for a charge no more than your
> -    cost of physically performing source distribution, a complete
> -    machine-readable copy of the corresponding source code, to be
> -    distributed under the terms of Sections 1 and 2 above on a medium
> -    customarily used for software interchange; or,
> -
> -    c) Accompany it with the information you received as to the offer
> -    to distribute corresponding source code.  (This alternative is
> -    allowed only for noncommercial distribution and only if you
> -    received the program in object code or executable form with such
> -    an offer, in accord with Subsection b above.)
> -
> -The source code for a work means the preferred form of the work for
> -making modifications to it.  For an executable work, complete source
> -code means all the source code for all modules it contains, plus any
> -associated interface definition files, plus the scripts used to
> -control compilation and installation of the executable.  However, as a
> -special exception, the source code distributed need not include
> -anything that is normally distributed (in either source or binary
> -form) with the major components (compiler, kernel, and so on) of the
> -operating system on which the executable runs, unless that component
> -itself accompanies the executable.
> -
> -If distribution of executable or object code is made by offering
> -access to copy from a designated place, then offering equivalent
> -access to copy the source code from the same place counts as
> -distribution of the source code, even though third parties are not
> -compelled to copy the source along with the object code.
> -
> -  4. You may not copy, modify, sublicense, or distribute the Program
> -except as expressly provided under this License.  Any attempt
> -otherwise to copy, modify, sublicense or distribute the Program is
> -void, and will automatically terminate your rights under this License.
> -However, parties who have received copies, or rights, from you under
> -this License will not have their licenses terminated so long as such
> -parties remain in full compliance.
> -
> -  5. You are not required to accept this License, since you have not
> -signed it.  However, nothing else grants you permission to modify or
> -distribute the Program or its derivative works.  These actions are
> -prohibited by law if you do not accept this License.  Therefore, by
> -modifying or distributing the Program (or any work based on the
> -Program), you indicate your acceptance of this License to do so, and
> -all its terms and conditions for copying, distributing or modifying
> -the Program or works based on it.
> -
> -  6. Each time you redistribute the Program (or any work based on the
> -Program), the recipient automatically receives a license from the
> -original licensor to copy, distribute or modify the Program subject to
> -these terms and conditions.  You may not impose any further
> -restrictions on the recipients' exercise of the rights granted herein.
> -You are not responsible for enforcing compliance by third parties to
> -this License.
> -
> -  7. If, as a consequence of a court judgment or allegation of patent
> -infringement or for any other reason (not limited to patent issues),
> -conditions are imposed on you (whether by court order, agreement or
> -otherwise) that contradict the conditions of this License, they do not
> -excuse you from the conditions of this License.  If you cannot
> -distribute so as to satisfy simultaneously your obligations under this
> -License and any other pertinent obligations, then as a consequence you
> -may not distribute the Program at all.  For example, if a patent
> -license would not permit royalty-free redistribution of the Program by
> -all those who receive copies directly or indirectly through you, then
> -the only way you could satisfy both it and this License would be to
> -refrain entirely from distribution of the Program.
> -
> -If any portion of this section is held invalid or unenforceable under
> -any particular circumstance, the balance of the section is intended to
> -apply and the section as a whole is intended to apply in other
> -circumstances.
> -
> -It is not the purpose of this section to induce you to infringe any
> -patents or other property right claims or to contest validity of any
> -such claims; this section has the sole purpose of protecting the
> -integrity of the free software distribution system, which is
> -implemented by public license practices.  Many people have made
> -generous contributions to the wide range of software distributed
> -through that system in reliance on consistent application of that
> -system; it is up to the author/donor to decide if he or she is willing
> -to distribute software through any other system and a licensee cannot
> -impose that choice.
> -
> -This section is intended to make thoroughly clear what is believed to
> -be a consequence of the rest of this License.
> -
> -  8. If the distribution and/or use of the Program is restricted in
> -certain countries either by patents or by copyrighted interfaces, the
> -original copyright holder who places the Program under this License
> -may add an explicit geographical distribution limitation excluding
> -those countries, so that distribution is permitted only in or among
> -countries not thus excluded.  In such case, this License incorporates
> -the limitation as if written in the body of this License.
> -
> -  9. The Free Software Foundation may publish revised and/or new versions
> -of the General Public License from time to time.  Such new versions will
> -be similar in spirit to the present version, but may differ in detail to
> -address new problems or concerns.
> -
> -Each version is given a distinguishing version number.  If the Program
> -specifies a version number of this License which applies to it and "any
> -later version", you have the option of following the terms and conditions
> -either of that version or of any later version published by the Free
> -Software Foundation.  If the Program does not specify a version number of
> -this License, you may choose any version ever published by the Free Software
> -Foundation.
> -
> -  10. If you wish to incorporate parts of the Program into other free
> -programs whose distribution conditions are different, write to the author
> -to ask for permission.  For software which is copyrighted by the Free
> -Software Foundation, write to the Free Software Foundation; we sometimes
> -make exceptions for this.  Our decision will be guided by the two goals
> -of preserving the free status of all derivatives of our free software and
> -of promoting the sharing and reuse of software generally.
> -
> -                            NO WARRANTY
> -
> -  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
> -FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
> -OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
> -PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
> -OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> -MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
> -TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
> -PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
> -REPAIR OR CORRECTION.
> -
> -  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
> -WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
> -REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
> -INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
> -OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
> -TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
> -YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
> -PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
> -POSSIBILITY OF SUCH DAMAGES.
> -
> -                     END OF TERMS AND CONDITIONS
> -
> -            How to Apply These Terms to Your New Programs
> -
> -  If you develop a new program, and you want it to be of the greatest
> -possible use to the public, the best way to achieve this is to make it
> -free software which everyone can redistribute and change under these terms.
> -
> -  To do so, attach the following notices to the program.  It is safest
> -to attach them to the start of each source file to most effectively
> -convey the exclusion of warranty; and each file should have at least
> -the "copyright" line and a pointer to where the full notice is found.
> -
> -    <one line to give the program's name and a brief idea of what it does.>
> -    Copyright (C) <year>  <name of author>
> -
> -    This program is free software; you can redistribute it and/or modify
> -    it under the terms of the GNU General Public License as published by
> -    the Free Software Foundation; either version 2 of the License, or
> -    (at your option) any later version.
> -
> -    This program is distributed in the hope that it will be useful,
> -    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -    GNU General Public License for more details.
> -
> -    You should have received a copy of the GNU General Public License along
> -    with this program; if not, write to the Free Software Foundation, Inc.,
> -    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -
> -Also add information on how to contact you by electronic and paper mail.
> -
> -If the program is interactive, make it output a short notice like this
> -when it starts in an interactive mode:
> -
> -    Gnomovision version 69, Copyright (C) year name of author
> -    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
> -    This is free software, and you are welcome to redistribute it
> -    under certain conditions; type `show c' for details.
> -
> -The hypothetical commands `show w' and `show c' should show the appropriate
> -parts of the General Public License.  Of course, the commands you use may
> -be called something other than `show w' and `show c'; they could even be
> -mouse-clicks or menu items--whatever suits your program.
> -
> -You should also get your employer (if you work as a programmer) or your
> -school, if any, to sign a "copyright disclaimer" for the program, if
> -necessary.  Here is a sample; alter the names:
> -
> -  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
> -  `Gnomovision' (which makes passes at compilers) written by James Hacker.
> -
> -  <signature of Ty Coon>, 1 April 1989
> -  Ty Coon, President of Vice
> -
> -This General Public License does not permit incorporating your program into
> -proprietary programs.  If your program is a subroutine library, you may
> -consider it more useful to permit linking proprietary applications with the
> -library.  If this is what you want to do, use the GNU Lesser General
> -Public License instead of this License.
> diff --git a/LICENSES.txt b/LICENSES.txt
> new file mode 100644
> index 0000000..1477ba9
> --- /dev/null
> +++ b/LICENSES.txt
> @@ -0,0 +1,13 @@
> +ima-evm-utils is provided under following licenses:
> +
> +libimaevm is provided under:
> +
> +	SPDX-License-Identifier: LGPL-2.0-or-later
> +
> +	https://spdx.org/licenses/LGPL-2.0-or-later.html
> +
> +evmctl is provided under:
> +
> +	SPDX-License-Identifier: GPL-2.0-or-later
> +
> +	https://spdx.org/licenses/GPL-2.0-or-later.html
> diff --git a/src/evmctl.c b/src/evmctl.c
> index d050b5e..2245a71 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * ima-evm-utils - IMA/EVM support utilities
>    *
> @@ -10,30 +11,6 @@
>    *                 <dmitry.kasatkin@intel.com>
>    *                 <d.kasatkin@samsung.com>
>    *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> - * As a special exception, the copyright holders give permission to link the
> - * code of portions of this program with the OpenSSL library under certain
> - * conditions as described in each individual source file and distribute
> - * linked combinations including the program with the OpenSSL library. You
> - * must comply with the GNU General Public License in all respects
> - * for all of the code used other than as permitted herein. If you modify
> - * file(s) with this exception, you may extend this exception to your
> - * version of the file(s), but you are not obligated to do so. If you do not
> - * wish to do so, delete this exception statement from your version. If you
> - * delete this exception statement from all source files in the program,
> - * then also delete it in the license file.
> - *
>    * File: evmctl.c
>    *	 IMA/EVM control program
>    */
> diff --git a/src/hash_info.gen b/src/hash_info.gen
> index 08d4a94..9f54c88 100755
> --- a/src/hash_info.gen
> +++ b/src/hash_info.gen
> @@ -1,18 +1,10 @@
>   #!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   #
>   # Generate hash_info.h from kernel headers
>   #
>   # Copyright (C) 2018 <vt@altlinux.org>
>   #
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2, or (at your option)
> -# any later version.
> -#
> -# This program is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -# GNU General Public License for more details.
>   
>   KERNEL_HEADERS=$1
>   HASH_INFO_H=uapi/linux/hash_info.h
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 8e24f08..24442d5 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: LGPL-2.0-or-later */
>   /*
>    * ima-evm-utils - IMA/EVM support utilities
>    *
> @@ -10,30 +11,6 @@
>    *                 <dmitry.kasatkin@intel.com>
>    *                 <d.kasatkin@samsung.com>
>    *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> - * As a special exception, the copyright holders give permission to link the
> - * code of portions of this program with the OpenSSL library under certain
> - * conditions as described in each individual source file and distribute
> - * linked combinations including the program with the OpenSSL library. You
> - * must comply with the GNU General Public License in all respects
> - * for all of the code used other than as permitted herein. If you modify
> - * file(s) with this exception, you may extend this exception to your
> - * version of the file(s), but you are not obligated to do so. If you do not
> - * wish to do so, delete this exception statement from your version. If you
> - * delete this exception statement from all source files in the program,
> - * then also delete it in the license file.
> - *
>    * File: imaevm.h
>    *	 IMA/EVM header file
>    */
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index ce4f6f7..5e02c06 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: LGPL-2.0-or-later
>   /*
>    * ima-evm-utils - IMA/EVM support utilities
>    *
> @@ -10,30 +11,6 @@
>    *                 <dmitry.kasatkin@intel.com>
>    *                 <d.kasatkin@samsung.com>
>    *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> - * As a special exception, the copyright holders give permission to link the
> - * code of portions of this program with the OpenSSL library under certain
> - * conditions as described in each individual source file and distribute
> - * linked combinations including the program with the OpenSSL library. You
> - * must comply with the GNU General Public License in all respects
> - * for all of the code used other than as permitted herein. If you modify
> - * file(s) with this exception, you may extend this exception to your
> - * version of the file(s), but you are not obligated to do so. If you do not
> - * wish to do so, delete this exception statement from your version. If you
> - * delete this exception statement from all source files in the program,
> - * then also delete it in the license file.
> - *
>    * File: libimaevm.c
>    *	 IMA/EVM library
>    */
> diff --git a/src/pcr.h b/src/pcr.h
> index 205bae8..6f38c8a 100644
> --- a/src/pcr.h
> +++ b/src/pcr.h
> @@ -1,3 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
>   int tpm2_pcr_supported(void);
>   int tpm2_pcr_read(const char *algo_name, uint32_t pcr_handle, uint8_t *hwpcr,
>   		 int len, char **errmsg);
> diff --git a/src/pcr_ibmtss.c b/src/pcr_ibmtss.c
> index 3275b20..72a7d3d 100644
> --- a/src/pcr_ibmtss.c
> +++ b/src/pcr_ibmtss.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Support PCR reading implementation based on IBM TSS2
>    *
> diff --git a/src/pcr_tss.c b/src/pcr_tss.c
> index 10930e2..26b77dd 100644
> --- a/src/pcr_tss.c
> +++ b/src/pcr_tss.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * ima-evm-utils - IMA/EVM support utilities
>    *
> @@ -10,30 +11,6 @@
>    *                 <dmitry.kasatkin@intel.com>
>    *                 <d.kasatkin@samsung.com>
>    *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> - * As a special exception, the copyright holders give permission to link the
> - * code of portions of this program with the OpenSSL library under certain
> - * conditions as described in each individual source file and distribute
> - * linked combinations including the program with the OpenSSL library. You
> - * must comply with the GNU General Public License in all respects
> - * for all of the code used other than as permitted herein. If you modify
> - * file(s) with this exception, you may extend this exception to your
> - * version of the file(s), but you are not obligated to do so. If you do not
> - * wish to do so, delete this exception statement from your version. If you
> - * delete this exception statement from all source files in the program,
> - * then also delete it in the license file.
> - *
>    * File: pcr_tss.c
>    *	 PCR reading implementation based on Intel TSS2
>    */
> diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
> index 39ff8f7..9fe4248 100644
> --- a/src/pcr_tsspcrread.c
> +++ b/src/pcr_tsspcrread.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * ima-evm-utils - IMA/EVM support utilities
>    *
> @@ -10,30 +11,6 @@
>    *                 <dmitry.kasatkin@intel.com>
>    *                 <d.kasatkin@samsung.com>
>    *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> - * As a special exception, the copyright holders give permission to link the
> - * code of portions of this program with the OpenSSL library under certain
> - * conditions as described in each individual source file and distribute
> - * linked combinations including the program with the OpenSSL library. You
> - * must comply with the GNU General Public License in all respects
> - * for all of the code used other than as permitted herein. If you modify
> - * file(s) with this exception, you may extend this exception to your
> - * version of the file(s), but you are not obligated to do so. If you do not
> - * wish to do so, delete this exception statement from your version. If you
> - * delete this exception statement from all source files in the program,
> - * then also delete it in the license file.
> - *
>    * File: pcr_tsspcrread.c
>    *	 PCR reading implementation based on IBM TSS2
>    */
> diff --git a/src/utils.c b/src/utils.c
> index 294dac5..7f17ec6 100644
> --- a/src/utils.c
> +++ b/src/utils.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * utils: set of common functions
>    *
> diff --git a/src/utils.h b/src/utils.h
> index 9ea179f..9fe1068 100644
> --- a/src/utils.h
> +++ b/src/utils.h
> @@ -1,3 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
>   #include <ctype.h>
>   #include <sys/types.h>
>   
> diff --git a/tests/functions.sh b/tests/functions.sh
> index c39b894..9c4b1ab 100755
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -1,19 +1,10 @@
>   #!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   #
>   # ima-evm-utils tests bash functions
>   #
>   # Copyright (C) 2020 Vitaly Chikunov <vt@altlinux.org>
>   #
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2, or (at your option)
> -# any later version.
> -#
> -# This program is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -# GNU General Public License for more details.
>   
>   # Tests accounting
>   declare -i testspass=0 testsfail=0 testsskip=0
> diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
> index 601ded2..2364aeb 100755
> --- a/tests/gen-keys.sh
> +++ b/tests/gen-keys.sh
> @@ -1,19 +1,10 @@
>   #!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   #
>   # Generate keys for the tests
>   #
>   # Copyright (C) 2020 Vitaly Chikunov <vt@altlinux.org>
>   #
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2, or (at your option)
> -# any later version.
> -#
> -# This program is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -# GNU General Public License for more details.
>   
>   # shellcheck disable=SC2043
>   
> diff --git a/tests/ima_hash.test b/tests/ima_hash.test
> index 9a8d7b6..2dc8244 100755
> --- a/tests/ima_hash.test
> +++ b/tests/ima_hash.test
> @@ -1,19 +1,10 @@
>   #!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   #
>   # evmctl ima_hash tests
>   #
>   # Copyright (C) 2020 Vitaly Chikunov <vt@altlinux.org>
>   #
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2, or (at your option)
> -# any later version.
> -#
> -# This program is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -# GNU General Public License for more details.
>   
>   cd "$(dirname "$0")" || exit 1
>   PATH=../src:$PATH
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 1b6cf2a..ecaf5f3 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -1,19 +1,10 @@
>   #!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   #
>   # evmctl {,ima_}{sign,verify} tests
>   #
>   # Copyright (C) 2020 Vitaly Chikunov <vt@altlinux.org>
>   #
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2, or (at your option)
> -# any later version.
> -#
> -# This program is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -# GNU General Public License for more details.
>   
>   cd "$(dirname "$0")" || exit 1
>   PATH=../src:$PATH
> diff --git a/tests/test_mmap.c b/tests/test_mmap.c
> index 63e7597..243726a 100644
> --- a/tests/test_mmap.c
> +++ b/tests/test_mmap.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
>    *

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat


