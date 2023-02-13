Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5740B694E9E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Feb 2023 19:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBMSCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Feb 2023 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBMSCX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Feb 2023 13:02:23 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9541216339
        for <linux-integrity@vger.kernel.org>; Mon, 13 Feb 2023 10:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676311339; bh=thJs4ClSmOLBC+CkiUuia+gADz4iDjPF3AwZ+FR51wA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=aUPLJ1mukrb+3PVqQnoDj5wrSLa7IxqqzdPC7vQZT4p97+CxTwE/XhhDhyJUaMeCRD261AGGk9BvIbXEuMzrZ4Amu9St59Yvd7bHUxjdViBiGNv8LDsvhXokrGnA6qZHzKXrQecAI23LhVb98X/VszwLULxPFzioczh+8XT8uKZIC5V2ndWzaKSPzgMNALxDYRmtTEWKao/lChjagadq4OV/P6MBoMIhvuCGkY0/L9B29Yk+V1pLOR9+yqo2WoMZD+rOfJeop65K9gWybCLMZESzjTa9OSYSBIw3BKvsGZ9hMytl5HMtSLhWcXbquz2V/V4PgQ5AtBHIP0DO7kO4YQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676311339; bh=914jzUAEXgJ4D3MxKzCvC/wySFMTIV/GDUX0jGcnKxF=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=l3dDlLKZpirqujoPRMfwPqwjMESjMa9gFqXzu+wiMs9PRYhI72vBBBS9VmFvLPBAnXy1DckRreBwz8qXsEaL4tTs1F4bg6w3nTnnCMxiM+Aj0VSEWzzKGN4N+GPhW8CHL/WVB2NngmpUcBlpf+x/9jCA4sNTW9digZLWdBTeupavkJrTrzZd74ntXPN3djmyY6UdrvD9q394CJ654yqOVWBw/8CLQf6/QecbYF/raMDHBVzLrKI2jJHtzRMUmVng4JwPpuHjjO8K9Rpl+Jm4n2RHDXDfEF1AfMf4qN/4K3oxaq7BWuobDq/83RwENkbBnq6a+nsAZOOL6S5mzxDCWA==
X-YMail-OSG: hDuQzZoVM1m0LhRtKLSgAFu2auAUY_ESJF5ZrdFcKfrt6UYp2dP3EZg3eRaIw8T
 LYTAmQDAdrrsCG6tPvdCTD3DaUNXbG0qtXaj08Q_qtIXsvTQmUG2BbPhotDCmtV5Wdr4KFGeuBXu
 WnRJZS7obZAG2u0p317_DnQnQiEJkDCFByPy4swuBWrf2zWtKk6nl7Pqa9jaqvvrxSua3O0.Uau_
 Vxc.lE7.DKX.uP.Y8cHJ9FVoNi8ZlDQhG5BSAMhEGfTAnEjfzTuRUt.YGSH6diTEkl64IQMmCg_P
 NZ8vrVyuz_9dJYJAgm0WhrGzje4pVOlWs5bzcaY9ADPjhbd3o.W6IC3Wqcy1hdM.SvmABGDVMYvG
 ZLqxxVf80Vz9T7Kd2mAQApxd5QQjSrtsdE0QbG6qBO9aTo.FRUc19mWSsBkPqHC3oNmco_Kqp5O9
 QxiwYNTM24Mm8ff.bJa.pUhpQsiy5wMW79pCzVcnS1WEKJD4NI.3DDh60nmGEli5gpghIkmzdeC9
 4wy8P1i2WsWxu27mOFHvXRaEybMH9sYa8A8zbc3JRc3RQHANk_iJ5dcSXxVHMTiAMnFkxGddw4C3
 uLqiBTqrT1QTSdpnCMvZOD0qfiAHhlEQq1x552w4l9VlYoCVmlNo9jHM8udMtPOdBPl4xqMsXFeT
 6YTv.3gsqoxGPZsVMs8EnjsfFUl6oJsZ9DRb9xZ0QrpRcnSs4TZGqyyWkOUPUG8J7u9IkBONHoC6
 mIjTY5RpUi9QMay4_QAHLNcldNE82xhdNbG6BPxG9gfNOlhxuZWGNMx0StabjslIpsNiyeeUtsOu
 mSDNyuYd1r0Hsk1Hy1RvcrYNOlg.yg18i_3uaMiw3PFM_6ukEiDCHcSaNPj7iHpgCYfXhZP0g5n8
 c1KRtw7Bbd3xltvJRk0vlo30TRUQoWWkqojPRGYMk7rsPhV6n9Vd2W17uMhkjKmSLwdlpIpWrSMl
 MEEiPpUFQ1nqMhWiT1wldwzPfHIiyrL0yUH7yZNr1p.1OjTuxFa0hPK.FkzpnUe2exftbyKji5TM
 EzsTerIr0E8XO.j94PgiK6iB7C4.lg0btTqKpBWIWSme6NF0Jd1HghgtC.4FYKN.5gUEc5ZSFtHT
 otDTva58tOnQ5iVsdxj6j7VvVEEFxNH0vHoathHYV5XCjKOI9uIFq75GaS0AcQQia6.M4JMTPOro
 RQCYpy9eu2XiJXLsBFIaNklqJzqs52Tpx_tz38pMb6cUdT6Eu5f85koehHWeH3IaR8.DmEkpTP8G
 PmScy.vnyS3_cdxEANiIw.WAW1YjofS80sGmbBVYrinXaKL10B7LZYWYpxM8bfwNqpsnUTu6yMy2
 q9rhOIDENS8wBODtXajrnOinEPY8svfEISz_XT1MDlkpIdx.4CraGIV8KHS6GyTjMwsagXe4u7hF
 H15bNlbwLlZng2jbeI5ZhM0eao9IbAKuWKmpPfqxNNKFqk6nakQNc5E2Qj_DNIL9BQGnk3ZFXSu3
 R59Tn4zhafU0wP679BnXlsErUt1Q44d_q5KL_EHnHZBAlpysKBUtDxSzgpgdyQJuGtnRSolLijsm
 rOdK56NO8e_3vY0K6QiOJcUBNFDN_6wfbrEPrv4ntu.Bqchb2tu6XyRuSj8vNRctw_YUI89vTDUp
 he6NDPN2pJ3EjMddO4AWNdJ8ipy2TJnfs4E2xDT7DhcjwXwN7IUSc40FFN9wbKnkLF1kyUtA_gLB
 4tQ52QZ8XctexZIMw8GtiZJFYq_9opW7DD8VssL2Cfiy3BV0M44yfYASypY5ZljXZoUh6_s5SNMV
 TX77J8PZmPuVPUaQ.77zfn.sv6KeuaRvLcKgcFO0_.6W87Hq3ACB0Bp.o6TK_GnAKE9pBXuangMR
 5.sli.bTvlkqHOlkV5DMvKqjOyPCu9RmBIr4PpJ2BU5nQ8CHOjYQ1G4jMriges0qCZoltVluBybK
 sASbKxPgv7pOM65cPc5KZVY.aoRVTZg.EaFqcFZdGwEEjp4bJwhcJfpiJMZ9knp_N6ITz8actVjg
 X6xImbeX2UrEVSGgrfLwRaglgu.nJ4YwqSLyydF1Of6qYbv18TIx5HvnfeiBWxWoY22BF1aohVU8
 .obJs840zgFEbUueHPITy6imfk7.Je2FHk4Ym8J3DBsqPxN9ib_8jIQbOfknocHpUcsrLl.LqEpD
 zq5SSlkQRq6NHPFv10DLZ55qFVc72oJFZCrW64wg9QSjgzJih6mmVvCbO7_7qL72hvwCviRZJ1Tk
 oUP3IxYxOOM0SnxTt4mMaQeqwF7.fLMj6PVvKfZp1tNdQMy8kqTbYa11JiBGIZghsZzqNpXA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Feb 2023 18:02:19 +0000
Received: by hermes--production-gq1-655ddccc9-4ln2x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f87940cc2d7ccc9948a0dc7cbd108b67;
          Mon, 13 Feb 2023 18:02:17 +0000 (UTC)
Message-ID: <553358e7-1bd7-c416-0e0f-ee504c0d0c66@schaufler-ca.com>
Date:   Mon, 13 Feb 2023 10:02:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/14] Implement CAP_TRUST capability.
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        shallyn@cisco.com, corbet@lwn.net, casey@schaufler-ca.com
References: <20230204050954.11583-1-greg@enjellic.com>
 <20230204050954.11583-5-greg@enjellic.com>
 <a12483d1-9d57-d429-789b-9e47ff575546@schaufler-ca.com>
 <20230213114313.GA15496@wind.enjellic.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230213114313.GA15496@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/13/2023 3:43 AM, Dr. Greg wrote:
> On Sat, Feb 04, 2023 at 06:54:20PM -0800, Casey Schaufler wrote:
>
> Looping in some others, given that this issue is fundamental to
> influencing how Linux can do security, also Sergey who raised a
> similar issue to Casey.
>
> Apologies for the delay in responding to this, catching up on issues
> after a week of travel.
>
>> On 2/3/2023 9:09 PM, Dr. Greg wrote:
>>> TSEM was designed to support a Trust Orchestration System (TOS)
>>> security architecture.  A TOS based system uses the concept of a
>>> minimum Trusted Computing Base of utilities, referred to as trust
>>> orchestrators, that maintain workloads in a trusted execution
>>> state.  The trust orchestrators are thus, from a security
>>> perspective, the most privileged assets on the platform.
>>>
>>> Introduce the CAP_TRUST capability that is defined as a
>>> capability that allows a process to alter the trust status of the
>>> platform.  In a fully trust orchestrated system only the
>>> orchestrators carry this capability bit.
>> How is this distinguishable from CAP_MAC_ADMIN?
> CAP_TRUST is being introduced to enable Linux security architects to
> ontologically differentiate processes that are allowed to modify
> security guarantees based on deontological (rule-based) predicates
> from processes allowed to modify security guarantees that are based on
> narratival (event-based) predicates.
>
> More generally, but less accurately, it allows security architectures
> to be shaped by both Kantian and Hegelian logic perspectives. [0]
>
> Given that the above will probably not be seen as an overly compelling
> argument, in and of itself .... :-), some technical observations in
> support of CAP_TRUST
>
> Dictating to the choir here, but a brief background for those
> following this discussion with an interest in security issues.
>
> In general, classic mandatory access controls (MAC) are policy based.
> For example, the standard bearers, SMACK and SeLinux, use classic
> subject/object philosophies.  A process (subject) has a role/label
> attached to it and objects acted on by the processes have a label
> associated with them.  Policies, that can be viewed as rules, usually
> quite elaborate and detailed for a whole system security policy, are
> developed that define how subject labels may or may not interact with
> object labels.
>
> TSEM introduces an alternate notion of a security policy, defined as a
> security model in TSEM parlance, that is created by unit testing of a
> platform or workload.  Precise descriptions of the security events
> generated by the testing are captured and used to maintain subsequent
> executions of the workload in a known security or trust state.

There's nothing fundamentally new here. You are claiming the common
practice of looking at the audit trail to develop "policy" is a new
"alternative notion" for security. You are familiar with SELinux's
audit2allow I assume.

> Both approaches are considered 'mandatory' in nature, since userspace
> cannot modify, in the case of policy based systems the labeling, or in
> event based systems the security model being enforced.  Unless of
> course a process has been assigned the capability to do so, hence this
> discussion.
>
> We are proposing CAP_TRUST as the privilege that is required by
> processes to maintain the security state of a workload based on a set
> of known valid security events.  In theory, and practice, it is
> orthogonal to the actions permitted by CAP_MAC_ADMIN.  Although,
> obviously, the intent of all these systems is to maintain a known
> security state, however different those schemes may be from a
> methodological perspective.

I read this as an argument for using CAP_MAC_ADMIN.

> In security architectures, the concept of 'trust' has connotated the
> notion of having a cryptographic guarantee of the state of a system.
> As the cover letter and documentation discuss, TSEM is about blending
> integrity measurement and mandatory access controls.
>
> Trust orchestrators are designed to provide an attestation that a
> workload has not deviated in any way from a previously defined
> security model, CAP_TRUST is the privilege required to influence this
> guarantee.  Once again, we view this as a different concept and
> objective than the ability to modify a security policy.

This is (to my simple mind) indistinguishable from the way SELinux is
used in distributions. SELinux does not require a CAP_TRUST, and only
uses CAP_MAC_ADMIN in certain unlikely error conditions which I believe
you don't encounter.

> Perhaps most importantly, TSEM shouldn't be viewed as an either/or
> proposition when it comes to classic subject/object MAC
> implementations.  A differentiation between CAP_TRUST and
> CAP_MAC_ADMIN is needed in order to allow both architectures to work
> together in a collaborative fashion.
>
> It would be perfectly reasonable to believe that a TSEM modeled
> workload would implement MAC (rules based) security controls.  In
> order to achieve event based security guarantees, a trust orchestrator
> drops CAP_TRUST for the workload process chain.  If CAP_MAC_ADMIN were
> used, it would potentially impair the ability of the workload to
> implement MAC policies, hence the desire to keep the privileges
> orthogonal.

If you're giving the workload process chain the ability to modify the
configuration of another LSM you are already on marshy ground.

> A quick example as to why this may be relevant.
>
> Since TSEM is a generic security modeling architecture, with full
> access to all security events, it can model the integrity of the
> security meta-data needed by MAC based policies, similar to what
> IMA/EVM does now, but entirely in the context of the LSM architecture
> itself.  It would therefore be reasonable to operate both security
> architectures in unison, with the event based TSEM protecting the
> rules based MAC implementation.
>
> Hopefully all of this helps clarify our thinking on this.
>
> After reviewing the TSEM ABI and documentation, Paul Moore had some
> questions and requests for clarification.  I am composing a response
> to that e-mail that may also assist in understanding the role for
> CAP_TRUST.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>
> [0]: In the interest of full disclosure, I need to officially
> attribute the notion of the philosophical differences between the two
> security architectures to a brilliant young cybersecurity engineer
> that I was privileged to mentor in the field of security modeling.  We
> struggled for a long time to explain why and how TSEM was different
> until he offered this inspired reasoning.  I recognize him, but will
> leave him anonymous due to his current roles and responsibilities.
