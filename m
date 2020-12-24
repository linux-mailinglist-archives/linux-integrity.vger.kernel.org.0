Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C862E2872
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Dec 2020 18:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgLXRvN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Dec 2020 12:51:13 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:36754
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbgLXRvN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Dec 2020 12:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608832227; bh=c2BZ/tZ5NHBqo2pNfKzscfVa5eKoELZdHYbIxFaTe8Y=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Er5w66IlBHY8JdATEEsEkNwt/IMERvWVabOnt2AkTALb39JvyIJlhh0UE6poSJNTv/SUnvQynyQ/CDQzKYP6x5cjmabdqDxAPiU6+IVyYcldoXW5IqvNIuQBkyyfcIeJVmMv7Q1s7hx0HLsblDSVEU6mUHA1IjoGHtuYm5pxVpaQUlwPqRpyirA7FphjS07nHGYU+iTatrcpWmx8KSE2wcLJxg8bTmA8nrTPLiWJVpGWQdDCSeHWKLPBUOvAceb6k03a+/1elO4y3jML30Y4QqM57ch+7LoWUhJ+I0mQxiHC5NuJFN7C0/EVPNkgBEKp4+E1NUmVh7V0Wb/L9MxAcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608832227; bh=mNhrq7jnfZqcL5hycWW1SKlo6J3XlKig4cHTFdlXdId=; h=Subject:To:From:Date:From:Subject; b=Xh472I3a/ji1v+DCB+tD/qO/tTbnY7ngzG8yu0/a5pqvppqbp8XRGt294uF1vTdwAnMsnzZ0ZB+lqgE0RZMrb+lmaXztocIKQIFujXLd+C3Vdy7tbVAy4iBSAvFqi5SBODHKk5fPhCdpLL7y9MrvIowj5JxeuRBhXzllCIsdFFxtWSzKbCDnTiGIiJiw9MP2hNuBH0l9dTf1KPtmGt2C+iS7EiqexrhGMSgmMHOENTVOucHcBz3t6TDjy9HKYSKT+ZKVggFBQpRdtn9M1wjrk0071jW9Z0M68kmA4TmE43lNBRhz70ouJc4yhE+HU1lA9jIQFPwphKvRp9YzfTflVQ==
X-YMail-OSG: rRA.43oVM1mYYTd_.zQtMIUuHbmfTyBME0p_aeFqHRjHHvALrMizvLOt7RfpPM5
 .zj83YfCbgwm5B7awRHiD1LK.dy9ezibWtg2tzTc4VGE6o8M2Sv8AKTQddWudjrCwKLzTbGBPEj7
 L52waKfrC0jhwz_LPZ0ymUlieOmkbXtdwcQrsSaG0DuhVkqNCqwBUeAlbfH57JwbAlk1cBQXqsCZ
 .xiDrqFYqpbp2Oqrj4MgQj1K5ggbzUpmNn37Hu4hQfS_qjIZBTVbsYIfEZxiNtwz8g8eO5HZalg5
 3H7dtSgwpabNDgrk5ZbFibDKPBCvo_cN5NXG3ZEhoX5FNcnj3LZxB.YQmPwlT30bI5cdB5riXfZT
 RGVqM2s.gpIvN6h9YvGjzWuiIpPFgFf7Yvm.yz1ghznHdgE2sDNOMCjEiguJjlB9X7f3WTlWVpsV
 buyj7R1oMpTFHma1RWockPiX7cDziN6S4udj0wtFqNsgsqiCg32TtlwqyQOxNcBZg6lW9WGvw2wF
 ejlz4abr734tih76zS82S9XQ9ZSO8aaA2X264yrIZhVCpc1miLRBHwl3DvleluEBakIXTTTbGS2A
 fhv5NhPFO35dM8zqetdrEjYNs9XfiZE8XKdp8VKWbZxsMulRgzw2tNvUYo6RcfbW0ekD8ZI9v6g6
 BX_j82dC_GyLmtGy_OW6wdiIop9P48r3UDD.SOcEcYaPNNjP3jQlMqvhwug3Lwem7fA3TQzWnBBl
 TL3stiwcYhCbAA0L6r1vremBE6MoC.mDOmTszASSYeUMrv8p9MBd1gL5g48IroVP3nbiIRCe7aOe
 D8DhQpqreP_jMoWjU3Y9yrBRS8PUTgKbqhfDB1LZDe3pgw8Vn9pLpGB1m7feKXjBu9yZ9lAQSmtV
 NAK4RC0geQxL1PRZSF43p.tD4oXL1iqzdmj4WcjonIZEzJM8TXNT4hENbfKPT2SwlGvyCygu6br9
 .HODS8rhBw0pKte182HrxP7G4sinm.GMLV8zqmUwG7YwMBbvQZkX8e2K3csM5vYmUgyRMXmoQ.3O
 k_.4IsEiyWIDpUPr0V19N1.d42ueXVWlBaebSE7wa.Go.lFwirQIeSobYilx9VWGZ.ZmGuCMZDth
 dfym8wQzQBliEuL8zb.66fZo0Tic4DbsNgSAFTf88eSSc0ahmIaZltZJAOnJPxSNICOyD_S9aGms
 w7egVQr.ytKb_f6ji1rx9r_JaH1xX6Jq3H18tgL5aGx7kCIQB6wDYvKga7QHyKPIL8eSPDMneTKB
 Sg.vfzdyYY6khP8kaifAyXbP65ul8Z7NrmqYyTpqQ5MIBbmcGh.JhHsCUtlV.YeNTUYKDU4NTB5_
 VltvpiyaC7AmSDpfWhcSYZ1.9dswcYrbMmSrpcgYeQxPSdnpyMgqJl5.i8bwY48TrS2B7sd6u63B
 KdxOo2rTko5UTF2fuIUMN01TpkCy8Hf9gs1VzHWvv38NG2QCoGkSJC0fBe.hzKMR4zEGNMeDfqhi
 dORlRU8E.7fz79FnOlSiZPLpTa3lUlpqWDH6noF56fzZKyj5yEwsodI7FP7EFzikDBrJD_tUcWX1
 jS9zWYKi9ucDhBinO3rz42fuYYngR1QEswAGshfBWgIR14dphzbOynFeSAJV5gLIusXmj493VARh
 WE0U994Zt0FDVSK4vampByoTk3T63FTlSNz0l.zwX8YPA_qJnk04j7Y.mc3aaeJ3iLd.GSpipeDV
 TKzwJJfnUft4P.AuA.xdBSvvI.8CvCs2B7TYrXCsjOzWa1bNGXG04qaUhnasAgJ93ObAaoDHWnJ5
 0VQXKWY4kHFlCNhGxZC2QX.AhJeNmUAxlUhNowjUXJ4W1jHTs97R79hFDL2A9HuGfh2zNzcQBM6o
 M9APbX1mlQvywoqirZZTezF8r1ylwmDnLOalzrkxxhWKHcx4NlEgeyKaYllmxadJv0Bu06lVG5Mm
 cQJ7uaGfZwKbJpaKnzRUULIAKkpUnG.9EPwAnbXEJKNGW4uvKbLanXUrGT4AqbwMI8amwInjtl8U
 zyfV.4aPr4Xb3f3npl_j_MytArz7_dRKXFgQ0STWBv39IlKBXZPR2mdGGn6is5B4559UqyH.inQe
 6phRK.DCb1w84gfjJVOzfB0GvDey83ErhJ5oC_Of_GSySxQZQIhI3K9k5aAIf9fJxAU.Mvp03ARz
 EwW.NJ4caqAtaw7s0in_lfCElU2sG9OLwt2YrKLQtnEuBDVk31GFvXToivn1YRMJwZRauMLACYPe
 d82FXleLaAfNEFIelI.IUIfXOs0_5OLgWODD_uNOMJ4Vu823yObRk2Nk6ydbBHLCVoJDFGprEVPM
 5iFzTN9s0b0MO6IMRaJ2nwn3Mchqnc2sM5V_4MQdnjNjB8Wam50CvjmhSY4fRiA4J9Rir5kwF495
 rOuVw3nnYsKrNVwjoGNpwhwO9vo2M4xFy.7TwgEU2CfTNtqQsm1ApJFC1UefLkP2kB..td86OGlH
 K3y599ZbvjhYJpwga6gZsiKEOkrdYHLbW76VRXGpNsxw7iP8O1mx7fKfDRLZY1Ubr5y729K2PAxv
 8ldjCtE4OeqG8G2vkcN52QFAA.s24LGnLK3xc61izZ_YZOQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Dec 2020 17:50:27 +0000
Received: by smtp422.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 924ef1fbb059c24acd1927fbb6867869;
          Thu, 24 Dec 2020 17:50:26 +0000 (UTC)
Subject: Re: Security module stacking patches review
To:     Mimi Zohar <zohar@linux.ibm.com>, Mimi Zohar <zohar@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <99c17a46-91ec-b934-333a-adb8c44e49da.ref@schaufler-ca.com>
 <99c17a46-91ec-b934-333a-adb8c44e49da@schaufler-ca.com>
 <70db5b26ebb0d95eaab584e4877a300dc6d1829d.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e7fb6c11-cd9f-750b-1767-8a6edad15545@schaufler-ca.com>
Date:   Thu, 24 Dec 2020 09:50:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <70db5b26ebb0d95eaab584e4877a300dc6d1829d.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/24/2020 7:05 AM, Mimi Zohar wrote:
> On Wed, 2020-12-16 at 09:49 -0800, Casey Schaufler wrote:
>> I am going to be putting out another revision of the LSM stacking
>> patch set just after 5.11-rc1. There are changes in the integrity
>> sub-system that need your ACK before I can get the code upstream.
>> Can I please get your review this time around?
> Thank you for the reminder.  I'm hoping to look at this patch set
> sometime next week.

Thank you, that is most appreciated.

> Mimi
