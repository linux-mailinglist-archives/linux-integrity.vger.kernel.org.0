Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B7244587A
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Nov 2021 18:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhKDRhi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Nov 2021 13:37:38 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:43558
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231679AbhKDRhi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Nov 2021 13:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1636047298; bh=KiWIeN1QL2RDSn9FtY24oxTjfHmvd3bFok1EmcZNowc=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=YJjHN5MgFAwT+DRDtY4+zZ/jE80Y3u7fsEnConmZUqSzrh642yRyWpaL/JYynKwsBhmQ4pyDda4OQEPoGsQsb4ZOwkZq9HDwM7W6VUwpwn9sVo6V68GQlglHp1yg8Q2T5vRE+KMYkb7rzKH+U0Rc50i4mo9rsbCxVLlQkUppwcL8NVs6dMjmWPE7ZA4hs9drAW35oPANImo+QdcLzXYH0LpZi8qgyEqrV96puVEoJHgu1+xo65JD5XYeDFKDmD8+6fnoBQu8KGhd/aUVizlYjhgcbIq/E6QGs1f7TULIy+RaeVp9L0DCiulteqOr4EzU6WdX9Cc5s19whR7yFDDopQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1636047298; bh=oMvGQu7aMsPhCFecyYDiV2mcoXADGS0O0YbWQZwJLUt=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=kXTL+Rdo4h99opcAyr5t+JFC447E9eCnvF0DLVDsjBaXuHagpdxto/5+3FZGgbwwJxUoJa2wQQOf1hYsG3IFFPtWlumcyBosPwxSnLk4sk2iBhmGjoeRNmRFqZ3NCZsbuDsp/uNPOyvuFSyM2MijpHjp94OjhF7b4j8HCLNnFRTN+5DVSb7fhEorX4u+G6ba8DKzghQ+LBHfJrHVuqjACCRjH/cgDUb5odJkAWNwOiedVzpCzd2pSRKBa5MsX6vvRWoZXCx49QCY1HfMNPnZFT4IDDhUInnhFdKoqWygk9vR8kKXQMCudMwlZodQF7Sv84BB7YvtSQwnLLFmg/iOtg==
X-YMail-OSG: IkBcjDMVM1kMZosSGo3dDI2gRYCZRd9vCnqaA9iOIO84sDkbFhElbpr2aBGziQi
 QWhqR6giX6a5_3URgMG2Oh3tmtomwyUCjGozKHdF1XCpDBIn4ncgKAmpzI6rkuOhKTFUyzjAuv47
 B9RBmxZ1uTz00KgWOTitTJOm5dzySDwIcz4xpXZtj7CcREchoahVOqvO.CIZcq4XHJTzl8LdtF.i
 5Fe2SU9oOxWqMeB.Ljc4M_4EHdLwCdOdIy_xGTNkNHkAucO7JzeWAtMsB.zeJ7hZJY0d3IYBoEgJ
 UPbKqsnsacmRTHEzIJFik.fhWdvmQOOLJFbOvbDViYyXVMkEfZzNE5wTQNb7NLW4.4YWqNfOJOkz
 MGziW9I3XRt.jmfa1uXGjPxdFlKDEfYwrjoRwI9oJ86vRMk1SzQWZ9HGLLY5dpCAAlbtAMEILMcS
 R_b9LFzcIMGvfKMP87vYOMik6alH9mat5eHFmYzzqhpLSb4ydqI4oT6vxa8DrV3P0jJlBF0tnhuX
 BBwGxnyoI38rNoDAQ21LglGKB6_bUi0fIuggKUVlgsV4U4gjhYZ8phTJqgFl3dXT3zEDTse3mYCQ
 UTlIPm9K0mdcOCOciYvdMC3.eNJSB2gxR82VTNczqirP_XG940QCRkooytsEae06GLM7ipRH4Kdq
 Pgmxof1VkNsZg7.rh36L72QGAgCgSysiu8YwOhdQI1dMLPvmTVqJ7XHc21XLeDh_1otu0L6vgxxf
 s4L1b7qXzQzaHDzBQVgBa_lReUBZzxyq5MGDMnNfx.daMllmsqGFwyN4taCE.UjHs.tfsyylhRJV
 2TCKTHvF9as4qUDuORj56q5PYvZpjzJjtyc1QAhhFKiNFYkQyiD5J_6O9omuteu.jFrrb1eoq.DV
 7lce7UblfBkIYwwJlW.cu5F6Gbv8qb6Bnk1aJltxMc2mOnx12_zrXeFSt2oyCrsc75jpnrDGuFzx
 siUGMo9J.OKrUvi8x28sSuh7jCI_DCpMn_pMD5sNvmvdgApapwb.ZNY3M_GaNigf2U1hqsvg2.B.
 o8zDknl_axkZVFowNqzxRMFk1W13cPoDsX4IKK96G9_pnNlF35bcsJPHB0NDv4wxvUPBy_n0xmLB
 NtKxo63bWqmZoh_ZSCu2h_bryK8z51hjEu453yIh3RXER9R6SIKEcqi8_XuOpNjSe.nGnNhV6_Yo
 qt1Qgy5zV_hrNKjESuhKI7QbGQGZUORQvkae3KThYIvuLw4e_rJeEqlKiffcYIEHDySlBbh2YNJz
 CSFxoV6t0YTbK6neHie44F_U_JcsnUlN_qYMEXgfeHr_JwT5AJfJXj1kY81Zh1iYA8g0YHuzZq59
 3qMnk0FaYYJLszcUyoMovN2_fOyug0d1eDVNy7yaWNCvxLguNyC79N_5DBtD6YhmTJiYUUHyUU0l
 bVKMROO1xvn4JBkUNwUoEknUxRWppaSUjYDpaLZfBbytFYyCS7QLyiq4JZuXKcs2OPLwpOx7rHMI
 szLrAn5qil8Z5FXyVTwaGgV5HnOM5BmbN4ACA1eWLe1Ng2qvnkeEKlT5wf.aKbJnWVgPNNVnl2RZ
 JFnk8K1cE6b.oLBAP2E_2PgzNHZCAlwrxTNGHdzy43QIvgawogK2IKlxsJpd5kGZ.fW_FDzc0.DY
 3ZUAxIsxEaJa8vvsN855PyCcrPPv0AG212DZFUzJ7UuJSGavUJikDOKq8Fek3YfY6RB3o3ZZjn7w
 xGtig6_IXRcUeWOCfPbG1YqEli4EZk.TAB9LmwBL2081rB9oV6PnwG1iO3Th2Fu1TeK3oxzZrkVz
 J6A.B1pbYqmWWV80oFCyGykC7LnizrytJz590RwjN3CSuP3HvD9e47LWKAOoaDXaCN8hKWvs3sbs
 5gAhkH.RR74TjSyixRyTWxO6AyExWU5J08_sHwcAoGjuzuQ_R.0Uk_gizUKAbljE1KUstscDzppC
 jHmUvCW42YphI7fvUbiWuxvsXQh7zLcr8uoZP6EFyaVblS.AdGI7JPUECp9uXCA3HeZOwSYinBm9
 7d.4QdkyCjIG4SoGroqVwYMq8R8_OBmFitVRwi07KwneVlXHYkXlLT587dsCkf5FZKMGVC_p71PE
 SD_xjNR7___X.qd_vTiW.tBdveOs8N7kx8E3sWelFOoAipz.aEtRM0kNY07guU4KkpXiSDBW0xZ6
 QVfz8UqdVpGsEN99C2dQNowMhqa4od3BP2N3waWqp32DByQCuzC9P_uSj0BJ.mCk.r9SKwkneh_a
 jqL2gkP_OtFHbaw78UNER79TgymOPR3IHEX5OqNxNTJM3jTOXsLzb_K3wWSYDc5lJzNFqWrwo
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 4 Nov 2021 17:34:58 +0000
Received: by kubenode520.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 626147f32b7378f74df93f560faac70e;
          Thu, 04 Nov 2021 17:34:55 +0000 (UTC)
Message-ID: <ef82b8f5-082c-d2c5-2781-8a6bd90306cd@schaufler-ca.com>
Date:   Thu, 4 Nov 2021 10:34:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Disassociating ima_filter_rule* from security_audit_rule*
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <ef82b8f5-082c-d2c5-2781-8a6bd90306cd.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.19266 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

After the last round of comments on the LSM stacking patches
Dmitry Mastykin <dmastykin@astralinux.ru> pointed out a
conundrum with reuse of the security_audit_rule functions
in integrity rule processing. The audit system wants to
match rules for any security module that as one. The
integrity system wants to match rules for a single, explicitly
defined LSM. The two sub-systems use common code in security.c
which needs to be changed to support multiple LSMs, but needs
to be changed differently for each of these cases. While it
would be possible to create frankensteinish versions of the
security_audit_rule functions that would handle both cases
it seems that creating "real" versions of the ima_filter_rule
functions would be considerably cleaner and easier to maintain
going forward.

I'm suggesting this now, while I'm still working on the patches,
in case there's a solid reason that frankencode is absolutely
everybody's favored approach. I plan to propose the disassociation
as a patch separate from and in advance of the stacking series.

Thanks all.

