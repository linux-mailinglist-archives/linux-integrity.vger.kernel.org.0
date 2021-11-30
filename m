Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470B1463D3A
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbhK3Rxp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 12:53:45 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:39167
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239409AbhK3Rxp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 12:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638294623; bh=vsHKDybZ2jrlosXiNEXb9J9i2f57wfoYS/tTO/wPOzs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=F8xLb7ZJrBUKw4Z/mH8dcR2q/uZKOSjVp6WuCJqWyYuPQrFtNCalzFD9gzTLHl+X2NUZ/N5tPRC1fJaC6xzvoY+jdKZNvKeBogy521YOgK3OMkvYU+mYB6vHftBf99sqt1ZnLQnUw26ZsWK+QdnThiPK8nr8QKPsggPrgYQ8j3Y/t9O0A9XdelpSsSj5wteAP7SID2ALL5ZgiLiY8wKGW+Cf/wggWVYyZ/pfxuxgTP3YhYPV9RgiLdgvQhwfOE7fJRbikXUvIrz9hAXvyyQrtFEwG5nQ8U3wobzSyM3oo71mugCq5SKC21O8Q9LonKOKldkIysSVxrtB2fKLekuU/A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638294623; bh=qi3mSy+twszzFxDrkUBLz/jnPjlyvDoBFOZSeBTfOK5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pJ+4AHAcpa4kbY4lsAE0j6T+VvMYKbfzT3XRnR36B8BWLMYFJ7+NP7LTkuXGepPw4rl3P9jyyqbSmpwrATvc6eGKwzQdHPRo8KIv1kWpz/dCantknO7WzDER1+CTHrYlZBJ9BpllLc8TZyy58MnrIVQ2/Pn7aVBEe1Lbs9npj+1wrlsqEosgVZvYkCVN0BCRHL8UW8+7zVt7wBV54U9YkBnhD9m8fTuTBgZ/zLDz63HypL5rHvmVVEDXkfD4Wccu9CKdSBBn6LQ2te6HWxVOor5K0Ss+5H3pV+tbGV1gQBdqSrtdlWIbZwiqig0V/CLwha92584z/RSvhRgiNaEccw==
X-YMail-OSG: JrOYuDIVM1kEVlj1bhV4sfQzsrstJ8PDyEmLySnsrphzrMXQ2zHd2SCZOJcQO8n
 iK._XGiSuCUSppRL_Xhx3ygQMaYVTUlEJr5DBqodUz5TKKN.ICJ38Z0IzLYVwQM3L64IRbYojFNw
 LffrIv1WCuaA3H8Cre_OzqNvNG9toDQ.Wkv2PQ0rytrL7c0EOv3iSbmM96imh_CQwRfxc3VdJp5j
 eNkGbPzeQl8UK3Ml0w3jXC847NgM__L.on1HaWgZVne15U2f3wvZQIdl_nbEBEral.b17j53acZT
 krya5VVfUcQAWfzcA12hjZ68MzXRJvIzJnMc14mSlugd938D._fchL2RCb59Huit1lQCxnKxAwz0
 OJxbQ8ZbpagbNn9rbUrz5IBzZ8NSxl8G4s6J7S_EiA5nvYMCiKHUtiZ0OxUHUT4gY4KeUSycoqRv
 byKroqB9x6jLPBnjmYUwGcAQYB0wKwxbtucoqwn8n0gWbRZE3pUrBaakehYo8cqLUnEoMhGDfUfQ
 588hCmp.gTQBM2uPSr0RKCVOQGQfv1qzQAjINeEcCV0xNvGVHLgME1S0HBt7.67VB530tMiptscW
 1Nj3hp_Y7mVHnTMn16F59oiW.XhE6ku0oWoCo3Bi2wS.6N3Ju.FAsOm0guHQtIW03df5u0BMd0rM
 _k3tpBxh8n05Ul1KKp_PTDFcoPtYLpYu4kCsMy.BzhC3y8fKUIpUovQiE8Ub_1Jk0kWHo6emKhOJ
 0S8q42X7x7fhM62B5nquIiM9RA2coYVSoIMAwUXJrlrlw9zDd5njxXSETLPV0psjeWPHbK0nzOvL
 MGuZaEFjw6RGZFxix9NWLBcnbMWi.SvhwQkVb.loLO0jFK1OGvI7zcImb6fNAmfFU0n1y7JO5cGh
 qtfOdTpl2XZmfGVcUI975WRO4.0J1p1yHEzw0CNALuayQd_2iQBl2ItHGFpxzUa7C5sdJFEQ2WDX
 DNtUxH5SaaaWy22eKB49UDEyMF4pGt.t5EJqG_eP3KSp8RewFHERNH2Xr50kyx8SpjA7r3I_s2js
 i.O0ZPq.w9Hl0UB.lnC_eDvwJNiiY76enlq_ZM0Z7zTwdyhddpRyxQafXZlJmHNPKgWYmdHDluDK
 wuC2y77PHG8Ul0S3.r_ttDRh7O9mSs1_rnTbK96n1ul4tu1elotVpS3oGWHlDrH9GDFQ_0hOhHmv
 QZ5zpozYEnFCWKZVO.ofOyxH90JdTYjDsxFBtwOyElcruFJJ2ZzD5xOMYQDTILGRB.uZ4dc0m1Yf
 2.sqckbCqpGHlugZ5SgIIgw.IgvcS6BGEM16fsHBabJNNPJR3eMWiMTkmHLY0Bn.dd0OO4SGn4bW
 PuP_ZMgQfU1milqZE_8n3ELRMmJUU32G8X0qR4ZNVA6jkMAFj9rd3_kScJPUMHV1HmA04XEG2iP.
 6nPFn76RqHckHDcabgfV2oMSfQBok_JmhBqT1HzfuVQ57NbD3Kpndmhn5trlp8mNY6eOR9lqfmyu
 .nWezuhNyKfzqbPiT381SQl5xTnBXBQfyF7LOeR58ZLmr8iLuW0kFE7E04phU2YFN52..beGNo2f
 KbjgeLpr523qBuMTLaKWqmV79yJHBFx4qOc8PA5zQT3rAjumzsc7W1PQzAhehpQcse4UPrYUpYur
 HX3b482MVNTRT3sxmc1u_ul6m9kSsLwiVLAQMfRXxxZ817OhgQWOFVYw6Gv2yY2__NVpMVjSg2Mc
 gHIUk84oXK_xcEHwUTihAWXJWDPjKvrIX.RYlKPLYFqkP5Psf8EMMOUL8PbRIir6rHBt7BCvv_YB
 Cx1VhHLfXjs0yQXyjMpbBUnRan7GcNXNZ57c1sCkmY5_C4opOmnRfiUURgZGSVsHJZ3J7KCj3WxM
 iG9_qayiz2525nZySOd5DNsnpi7Y1Fl4mTGnHAc77U4Oht84k6JQSmHOEFfB.DBboy29.uGS3cc_
 B7oqjJ1KflDfMedKvebaAkTV8OcXzA7H6T8YJPv5f41XbXfep7JvTDGVRLE6un0bycVyaypx6SHh
 LYn4RIuwPzCmtchAF8uXrO_g31bfbSAKnMvo4H8CEhl6pQv73ektBN89kUgMGe8LCQgqaGTWL2PP
 1qWHsRCBSx.OLXF1rjCL8jooKPq2RHWLEH7e8zswCTpbLUNCKJya6h_a9w93upa46wnISuG7.QTH
 85GfmoskM7iYmovf_L.VT0FFba55uPM2Bx6V9fGDlwpdQ.saxv_N0Z8wiKYKrN7V4pE9xl2p1LTa
 r9yAvSwfLqIlV8PdjfmMEl5sUeqA.wQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Nov 2021 17:50:23 +0000
Received: by kubenode542.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID da9e10bd5721b37c7f2ee8a0729d408b;
          Tue, 30 Nov 2021 17:50:17 +0000 (UTC)
Message-ID: <ad6a83da-f99f-a27f-6a22-712e530cfa2a@schaufler-ca.com>
Date:   Tue, 30 Nov 2021 09:50:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC 15/20] capabilities: Introduce CAP_INTEGRITY_ADMIN
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-16-stefanb@linux.ibm.com>
 <e482c499-8bff-72c8-bbda-1ecc5a7f3452@schaufler-ca.com>
 <957f65ce-df0e-5980-57c3-57c05291ccc6@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <957f65ce-df0e-5980-57c3-57c05291ccc6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/30/2021 9:41 AM, Stefan Berger wrote:
>
> On 11/30/21 12:27, Casey Schaufler wrote:
>> On 11/30/2021 8:06 AM, Stefan Berger wrote:
>>> From: Denis Semakin <denis.semakin@huawei.com>
>>>
>>> This patch introduces CAP_INTEGRITY_ADMIN, a new capability that allows
>>> to setup IMA (Integrity Measurement Architecture) policies per container
>>> for non-root users.
>>
>> Why not use CAP_MAC_ADMIN? IMA is a mandatory policy. The scope
>> is system security administration. It seems to fit your needs.
>> I introduced CAP_MAC_ADMIN for Smack, and believe that IMA using
>> it would be completely appropriate.
>
> Fine by me. I suppose we could be reusing it later on also for setting file extended attributes for IMA?

Yes. That would be completely consistent with the intention and the
Smack implementation.

>
>    Stefan
>
>
