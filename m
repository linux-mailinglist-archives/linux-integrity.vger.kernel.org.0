Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419465978EC
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Aug 2022 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiHQVbC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Aug 2022 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHQVbB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Aug 2022 17:31:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18B9F75D
        for <linux-integrity@vger.kernel.org>; Wed, 17 Aug 2022 14:31:00 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HLG564004458;
        Wed, 17 Aug 2022 21:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Uj7DjsHaa31LY9/ZjlxlEP9ovOPGLSPibBkOfGKggmY=;
 b=eyYVUOS16lDurAO2nXzDIqIZrywQpj8wqiTCvErnAFRg6byxetvgUE0+8tjE/W0flIfv
 qgYslUr2yHdj2SzH7fd74FYbbChKqLf/sG3hGjVOnonWZa5hbegGemWtTOAfc40A+hhm
 BuLa8evqazJs3DU0NcmM6Hy2gyqWgozoToylYv2SBLmIEBC4gBrU09zIDOpA+njkjMEY
 Qm4G3hhs2LzeBPcE8EhrD4QYZtqPUVk2srrK7D8txBSmKlgVLzNTElIBfYU/rG7eaXJ8
 7Mr6k9WiLqCFXYXuRrM5/exuyl2+/yhfzB0YCZ9zKh9yb3a6oSkmCToViwxEdBGj3G/U bw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j183g0a8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 21:30:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27HLLSEr006600;
        Wed, 17 Aug 2022 21:30:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3hx37jd0je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 21:30:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27HLUlwK31523192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 21:30:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6433FA4053;
        Wed, 17 Aug 2022 21:30:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDC4AA4051;
        Wed, 17 Aug 2022 21:30:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.49.180])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Aug 2022 21:30:45 +0000 (GMT)
Message-ID: <432588782021fb88e9e78d115e800ccb2d54c207.camel@linux.ibm.com>
Subject: Re: Bug in ima_inode_setxattr()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Seth Forshee <sforshee@kernel.org>
Date:   Wed, 17 Aug 2022 17:30:44 -0400
In-Reply-To: <20220817163152.g3ejdtzmp5df6m2x@wittgenstein>
References: <20220817163152.g3ejdtzmp5df6m2x@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mft_3_SeW0rreRwzMezXNfWOyz7250lJ
X-Proofpoint-GUID: Mft_3_SeW0rreRwzMezXNfWOyz7250lJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-08-17 at 18:31 +0200, Christian Brauner wrote:
> Hey Mimi, 
> Heim Roberto
> Hey everyone,
> 
> I'm currently reworking posix acls - well trying to - and so I'm also
> looking at various security hooks. Currently I'm looking at
> security_inode_setxattr() which calls ima_inode_setxattr() and I think
> it's doing strange things when system.posix_acl_{access,deafult} is
> passed as xattr. So we have:
> 
> ima_inode_setxattr(system.posix_acl_{access,default})
> -> ima_protect_xattr(system.posix_acl_{access,default})
>    -> evm_revalidate_status(system.posix_acl_{access,default})
>    -> validate_hash_algo(system.posix_acl_{access,default}))
> 
> Since this isn't an ima_protect_xattr() it will return 0. But
> evm_revalidate_status() will return true for posix acls as they seem to
> be included. In any case, this will cause validate_hash_algo() to run:
> 
> So the posix acl value is cast to a struct evm_ima_xattr_data:
> 
>         const struct evm_ima_xattr_data *xvalue = xattr_value;
> 
> then passed to:
> 
>         validate_hash_algo(struct dentry *dentry, const struct evm_ima_xattr_data *xattr_value, size_t xattr_value_len)
> 
> which then passes it to:
> 
>         enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value, int xattr_len)
> 
> which does:
> 
>         switch (xattr_value->type) {
>         case IMA_VERITY_DIGSIG:
>                 sig = (typeof(sig))xattr_value;
>                 if (sig->version != 3 || xattr_len <= sizeof(*sig) ||
>                     sig->hash_algo >= HASH_ALGO__LAST)
>                         return ima_hash_algo;
>                 return sig->hash_algo;
>         case EVM_IMA_XATTR_DIGSIG:
>                 sig = (typeof(sig))xattr_value;
>                 if (sig->version != 2 || xattr_len <= sizeof(*sig)
>                     || sig->hash_algo >= HASH_ALGO__LAST)
>                         return ima_hash_algo;
>                 return sig->hash_algo;
>         case IMA_XATTR_DIGEST_NG:
>                 /* first byte contains algorithm id */
>                 ret = xattr_value->data[0];
>                 if (ret < HASH_ALGO__LAST)
>                         return ret;
>                 break;
>         case IMA_XATTR_DIGEST:
>                 /* this is for backward compatibility */
>                 if (xattr_len == 21) {
>                         unsigned int zero = 0;
>                         if (!memcmp(&xattr_value->data[16], &zero, 4))
>                                 return HASH_ALGO_MD5;
>                         else
>                                 return HASH_ALGO_SHA1;
>                 } else if (xattr_len == 17)
>                         return HASH_ALGO_MD5;
>                 break;
>         }
> 
> unless I have a fundamental misunderstanding this can't possibly be
> right as you're casting a posix acl value to a struct
> evm_ima_xattr_data and then try to retrieve
> 
> Explaining my findings to Seth (Cced) he found that it got introduced by
> 50f742dd9147 "IMA: block writes of the security.ima xattr with unsupported algorithms"
> 
> Could you please fix this in ima_inode_setxattr() and please in a way
> that you never operate on raw posix acl values? I really would like to
> prevent further integrity assumptions about posix acls; I know evm
> already has some but let's not get ima involved in them as well...
> 
> (They are a pain to deal with and they represent very much structured
> binary data with {g,u}ids stored in them that need to be handled in the
> VFS layer.)

Thank you for the clear explanation of the problem.  The hash algorithm
check should have been right after the call to ima_protect_xattr(),
which would have limited it to just security.ima xattrs.

thanks,

Mimi

