Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6EE71FD81
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jun 2023 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjFBJTT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jun 2023 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjFBJS0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jun 2023 05:18:26 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E572C10F7;
        Fri,  2 Jun 2023 02:17:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QXcYM6zgnz9xwjV;
        Fri,  2 Jun 2023 17:05:59 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCX_OeTs3lkLZQCAw--.3279S2;
        Fri, 02 Jun 2023 10:17:20 +0100 (CET)
Message-ID: <62078920aa02c2912beeb33511fdf6636365e6c8.camel@huaweicloud.com>
Subject: Re: [PATCH v5 2/2] KEYS: asymmetric: Copy sig and digest in
 public_key_verify_signature()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        ebiggers@kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 02 Jun 2023 11:17:04 +0200
In-Reply-To: <fd161de5-61ce-94bf-96cf-65965115f981@linux.ibm.com>
References: <20221227142740.2807136-1-roberto.sassu@huaweicloud.com>
         <20221227142740.2807136-3-roberto.sassu@huaweicloud.com>
         <fd161de5-61ce-94bf-96cf-65965115f981@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCX_OeTs3lkLZQCAw--.3279S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1Duw15Ww4xGw45Jw4ktFb_yoWrKw4rpF
        Z5Wr4UKFyUJrn7CrZ3Ca18ta4rt3y0yw1ag3yfJ3W3CrnxZrykGryI9w47Wry7ArykGryx
        tr4UWws5ur1DXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj44DBAABss
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-06-01 at 17:00 -0400, Stefan Berger wrote:
> 
> On 12/27/22 09:27, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in linear
> > mapping") checks that both the signature and the digest reside in the
> > linear mapping area.
> > 
> > However, more recently commit ba14a194a434c ("fork: Add generic vmalloced
> > stack support") made it possible to move the stack in the vmalloc area,
> > which is not contiguous, and thus not suitable for sg_set_buf() which needs
> > adjacent pages.
> > 
> > Always make a copy of the signature and digest in the same buffer used to
> > store the key and its parameters, and pass them to sg_init_one(). Prefer it
> > to conditionally doing the copy if necessary, to keep the code simple. The
> > buffer allocated with kmalloc() is in the linear mapping area.
> > 
> > Cc: stable@vger.kernel.org # 4.9.x
> > Fixes: ba14a194a434 ("fork: Add generic vmalloced stack support")
> > Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> 
> I just ran into an issue with OpenBMC on ARM where EVM ECDSA signature verification failed due to invalid hashes being passed to the ECDSA signature verification algorithm. This patch here resolved the issue.
> 
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.

I did multiple attempts to have the patch included, but I didn't have
any luck with the maintainers (David, Jarkko).

It would be awesome if any maintainer picks it.

Thanks!

Roberto

> ---
> >   crypto/asymmetric_keys/public_key.c | 38 ++++++++++++++++-------------
> >   1 file changed, 21 insertions(+), 17 deletions(-)
> > 
> > diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> > index 2f8352e88860..49a3f7c01149 100644
> > --- a/crypto/asymmetric_keys/public_key.c
> > +++ b/crypto/asymmetric_keys/public_key.c
> > @@ -360,9 +360,10 @@ int public_key_verify_signature(const struct public_key *pkey,
> >   	struct crypto_wait cwait;
> >   	struct crypto_akcipher *tfm;
> >   	struct akcipher_request *req;
> > -	struct scatterlist src_sg[2];
> > +	struct scatterlist src_sg;
> >   	char alg_name[CRYPTO_MAX_ALG_NAME];
> > -	char *key, *ptr;
> > +	char *buf, *ptr;
> > +	size_t buf_len;
> >   	int ret;
> >   
> >   	pr_devel("==>%s()\n", __func__);
> > @@ -400,34 +401,37 @@ int public_key_verify_signature(const struct public_key *pkey,
> >   	if (!req)
> >   		goto error_free_tfm;
> >   
> > -	key = kmalloc(pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
> > -		      GFP_KERNEL);
> > -	if (!key)
> > +	buf_len = max_t(size_t, pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
> > +			sig->s_size + sig->digest_size);
> > +
> > +	buf = kmalloc(buf_len, GFP_KERNEL);
> > +	if (!buf)
> >   		goto error_free_req;
> >   
> > -	memcpy(key, pkey->key, pkey->keylen);
> > -	ptr = key + pkey->keylen;
> > +	memcpy(buf, pkey->key, pkey->keylen);
> > +	ptr = buf + pkey->keylen;
> >   	ptr = pkey_pack_u32(ptr, pkey->algo);
> >   	ptr = pkey_pack_u32(ptr, pkey->paramlen);
> >   	memcpy(ptr, pkey->params, pkey->paramlen);
> >   
> >   	if (pkey->key_is_private)
> > -		ret = crypto_akcipher_set_priv_key(tfm, key, pkey->keylen);
> > +		ret = crypto_akcipher_set_priv_key(tfm, buf, pkey->keylen);
> >   	else
> > -		ret = crypto_akcipher_set_pub_key(tfm, key, pkey->keylen);
> > +		ret = crypto_akcipher_set_pub_key(tfm, buf, pkey->keylen);
> >   	if (ret)
> > -		goto error_free_key;
> > +		goto error_free_buf;
> >   
> >   	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
> >   		ret = cert_sig_digest_update(sig, tfm);
> >   		if (ret)
> > -			goto error_free_key;
> > +			goto error_free_buf;
> >   	}
> >   
> > -	sg_init_table(src_sg, 2);
> > -	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
> > -	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> > -	akcipher_request_set_crypt(req, src_sg, NULL, sig->s_size,
> > +	memcpy(buf, sig->s, sig->s_size);
> > +	memcpy(buf + sig->s_size, sig->digest, sig->digest_size);
> > +
> > +	sg_init_one(&src_sg, buf, sig->s_size + sig->digest_size);
> > +	akcipher_request_set_crypt(req, &src_sg, NULL, sig->s_size,
> >   				   sig->digest_size);
> >   	crypto_init_wait(&cwait);
> >   	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
> > @@ -435,8 +439,8 @@ int public_key_verify_signature(const struct public_key *pkey,
> >   				      crypto_req_done, &cwait);
> >   	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
> >   
> > -error_free_key:
> > -	kfree(key);
> > +error_free_buf:
> > +	kfree(buf);
> >   error_free_req:
> >   	akcipher_request_free(req);
> >   error_free_tfm:

