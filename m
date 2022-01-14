Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A80A48E32E
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 05:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiANEMd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 23:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiANEMc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 23:12:32 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDFBC061574;
        Thu, 13 Jan 2022 20:12:32 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id l13so7527419qvz.10;
        Thu, 13 Jan 2022 20:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HCdJ4uc7ZQKFPkllkV4dH50qtsfh07hAIcC6QGtjAjo=;
        b=CGvzn0YiAiQClsUz38hGqQu+zgaIWQEk6d+nRVyWGjDvmJyjVKSfepejFcd/cpZu/u
         KFoDNe3JopPL3J1iCDsxSquL95/wxHAMcVSTkK6L1KaQK4QgkhDChsch2SnyEXQHoaIV
         4WhQQRmri3d53aWDjT1f+yQBxML7xO4k2Z7EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HCdJ4uc7ZQKFPkllkV4dH50qtsfh07hAIcC6QGtjAjo=;
        b=qCpxA2du+RCcL2KXl5lPWDOCgLX928Qwar7O3uHFOQfoGb4ZS67ni2H4jC9E3h0axG
         6DikSWXij0zPwtrHPeZqSM/4QVdP8DKpPW91DA8uileeJh4cp7vjmFAwKeyDpEMBDjKu
         VxngjUNG2lU8zxQTdtpjkjwsnC6MUY1qSj4Ce3X80mxHUmtB63B3QUsmr6nWkeLzzsIG
         ahkVn5hvJ5grKH85JPJ06L75aH14mo342jtE0YEdCYNZqXurpTwdlIMezvjt7qetfjP3
         OOy0jxLugPzggc/hMt/wN4ZH5GU+PqwSD5ck/CLdYINpHVEiJ0wnXnjj137+ooaUbGhr
         kNpA==
X-Gm-Message-State: AOAM531hh146pZljlAkIB9gJwKU40kUuhJis6megHwi5PuJm06xXmCji
        XiRGctQTfsOGbm9GviXNsJvQcOkAwh0z9tBth7wjX0PfuXR+rw==
X-Google-Smtp-Source: ABdhPJwdCGiKluxxPzuPKnAKD3FVrtW7ibv78sHE21tQel2iej6Ek+Nbf4oL4BrNxQ7KjEDWC9MacNzSY07j67xZ71s=
X-Received: by 2002:ad4:594b:: with SMTP id eo11mr6609927qvb.21.1642133551635;
 Thu, 13 Jan 2022 20:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20211104140211.6258-1-amirmizi6@gmail.com> <20211104140211.6258-5-amirmizi6@gmail.com>
In-Reply-To: <20211104140211.6258-5-amirmizi6@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 14 Jan 2022 04:12:18 +0000
Message-ID: <CACPK8Xe8Y35Jf4o8gG=+BHRQN=Y+yo12uW7RFFva3bNvna3OUA@mail.gmail.com>
Subject: Re: [PATCH v19 4/5] tpm: tpm_tis: Add tpm_tis_i2c driver
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, benoit.houyere@st.com,
        Eddie James <eajames@linux.ibm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        Tomer Maimon <tmaimon77@gmail.com>, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 4 Nov 2021 at 14:04, <amirmizi6@gmail.com> wrote:


> +static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr,
> +                                  u16 len, const u8 *value)
> +{
> +       struct tpm_tis_i2c_phy *phy =3D to_tpm_tis_i2c_phy(data);
> +       int ret =3D 0;
> +       int i =3D 0;
> +
> +       if (phy->iobuf) {
> +               if (len > TPM_BUFSIZE - 1)
> +                       return -EIO;
> +
> +               phy->iobuf[0] =3D address_to_register(addr);
> +               memcpy(phy->iobuf + 1, value, len);
> +
> +               struct i2c_msg msgs[] =3D {
> +                       {
> +                               .addr =3D phy->i2c_client->addr,
> +                               .len =3D len + 1,
> +                               .buf =3D phy->iobuf,
> +                       },
> +               };

I see this warning with GCC 11.2:

../drivers/char/tpm/tpm_tis_i2c.c: In function =E2=80=98tpm_tis_i2c_write_b=
ytes=E2=80=99:
../drivers/char/tpm/tpm_tis_i2c.c:114:17: warning: ISO C90 forbids
mixed declarations and code [-Wdeclaration-after-statement]

> +
> +               do {
> +                       ret =3D i2c_transfer(phy->i2c_client->adapter,
> +                                          msgs, ARRAY_SIZE(msgs));
> +                       // wait default GUARD_TIME of 250=C2=B5s
> +                       usleep_range(250, 300);
> +               } while (ret < 0 && i++ < TPM_RETRY);
> +       } else {
> +               u8 reg =3D address_to_register(addr);
> +
> +               struct i2c_msg msgs[] =3D {
> +                       {
> +                               .addr =3D phy->i2c_client->addr,
> +                               .len =3D sizeof(reg),
> +                               .buf =3D &reg,
> +                       },
> +                       {
> +                               .addr =3D phy->i2c_client->addr,
> +                               .len =3D len,
> +                               .buf =3D (u8 *)value,
> +                               .flags =3D I2C_M_NOSTART,
> +                       },
> +               };
> +
> +               do {
> +                       ret =3D i2c_transfer(phy->i2c_client->adapter, ms=
gs,
> +                                          ARRAY_SIZE(msgs));
> +                       // wait default GUARD_TIME of 250=C2=B5s
> +                       usleep_range(250, 300);
> +               } while (ret < 0 && i++ < TPM_RETRY);
> +       }
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +int tpm_tis_i2c_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
> +{
> +       __le16 result_le;
> +       int rc;
> +
> +       rc =3D data->phy_ops->read_bytes(data, addr, sizeof(u16),
> +                                      (u8 *)&result_le);
> +       if (!rc)
> +               *result =3D le16_to_cpu(result_le);
> +
> +       return rc;
> +}
> +
> +int tpm_tis_i2c_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
> +{
> +       __le32 result_le;
> +       int rc;
> +
> +       rc =3D data->phy_ops->read_bytes(data, addr, sizeof(u32),
> +                                      (u8 *)&result_le);
> +       if (!rc)
> +               *result =3D le32_to_cpu(result_le);
> +
> +       return rc;
> +}
> +
> +int tpm_tis_i2c_write32(struct tpm_tis_data *data, u32 addr, u32 value)
> +{
> +       __le32 value_le;
> +       int rc;
> +
> +       value_le =3D cpu_to_le32(value);
> +
> +       rc =3D data->phy_ops->write_bytes(data, addr, sizeof(u32),
> +                                       (u8 *)&value_le);
> +
> +       return rc;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
> +
> +static const struct tpm_tis_phy_ops tpm_i2c_phy_ops =3D {
> +       .read_bytes =3D tpm_tis_i2c_read_bytes,
> +       .write_bytes =3D tpm_tis_i2c_write_bytes,
> +       .read16 =3D tpm_tis_i2c_read16,
> +       .read32 =3D tpm_tis_i2c_read32,
> +       .write32 =3D tpm_tis_i2c_write32,
> +};
> +
> +static int tpm_tis_i2c_probe(struct i2c_client *dev, const struct i2c_de=
vice_id *id)
> +{
> +       struct tpm_tis_i2c_phy *phy;
> +       const u8 loc_init =3D 0;
> +       int rc;
> +
> +       phy =3D devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_i2c_phy),
> +                          GFP_KERNEL);
> +       if (!phy)
> +               return -ENOMEM;
> +
> +       phy->i2c_client =3D dev;
> +
> +       if (!i2c_check_functionality(dev->adapter, I2C_FUNC_NOSTART)) {
> +               phy->iobuf =3D devm_kmalloc(&dev->dev, TPM_BUFSIZE, GFP_K=
ERNEL);
> +               if (!phy->iobuf)
> +                       return -ENOMEM;
> +       }
> +
> +       /*select locality 0 (the driver will access only via locality 0)*=
/
> +       rc =3D tpm_tis_i2c_write_bytes(&phy->priv, TPM_LOC_SEL, 1, &loc_i=
nit);
> +       if (rc < 0)
> +               return rc;
> +
> +       return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_i2c_phy_=
ops,
> +                                       NULL);
> +}
> +
> +static const struct i2c_device_id tpm_tis_i2c_id[] =3D {
> +       {"tpm_tis_i2c", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> +
> +static const struct of_device_id of_tis_i2c_match[] =3D {
> +       { .compatible =3D "nuvoton,npct75x", },
> +       { .compatible =3D "tcg,tpm-tis-i2c", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> +
> +static struct i2c_driver tpm_tis_i2c_driver =3D {
> +       .driver =3D {
> +               .owner =3D THIS_MODULE,
> +               .name =3D "tpm_tis_i2c",
> +               .pm =3D &tpm_tis_pm,
> +               .of_match_table =3D of_match_ptr(of_tis_i2c_match),
> +       },
> +       .probe =3D tpm_tis_i2c_probe,
> +       .id_table =3D tpm_tis_i2c_id,
> +};
> +
> +module_i2c_driver(tpm_tis_i2c_driver);
> +
> +MODULE_DESCRIPTION("TPM Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>
